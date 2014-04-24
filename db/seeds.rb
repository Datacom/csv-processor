print "RuleSets: #{RuleSet.count} before, "
bnz     = RuleSet.where(name: 'BNZ'           ).first_or_create
westpac = RuleSet.where(name: 'Westpac'       ).first_or_create
wpc_crd = RuleSet.where(name: 'Westpac credit').first_or_create
puts "#{RuleSet.count} now"

print "FieldMappings: #{FieldMapping.count} before, "
[
  [bnz,     'Date',             'date'       ],
  [bnz,     'Amount',           'amount'     ],
  [bnz,     'Payee',            'other_party'],
  [bnz,     'Particulars',      'particulars'],
  [bnz,     'Code',             'code'       ],
  [bnz,     'Reference',        'reference'  ],
  [bnz,     'Tran Type',        'type'       ],
  [westpac, 'Date',             'date'       ],
  [westpac, 'Amount',           'amount'     ],
  [westpac, 'Other Party',      'other_party'],
  [westpac, 'Description',      'type'       ],
  [westpac, 'Reference',        'reference'  ],
  [westpac, 'Particulars',      'particulars'],
  [westpac, 'Analysis Code',    'code'       ],
  [wpc_crd, 'Amount',           'amount'     ],
  [wpc_crd, 'Other Party',      'other_party'],
  [wpc_crd, 'Credit Plan Name', 'type'       ],
  [wpc_crd, 'Transaction Date', 'date'       ],
  [wpc_crd, 'Foreign Details',  'reference'  ],
  [wpc_crd, 'City',             'particulars'],
  [wpc_crd, 'Country Code',     'code'       ],
].each do |set, src, out|
  FieldMapping.where(rule_set: set, src_field_name: src).first_or_create(out_field_name: out)
end
puts "#{FieldMapping.count} now"
