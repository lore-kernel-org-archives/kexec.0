Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aJDA4-0006Xx-8N
 for kexec@lists.infradead.org; Wed, 13 Jan 2016 04:35:57 +0000
Received: by mail-pa0-x22c.google.com with SMTP id ho8so90563849pac.2
 for <kexec@lists.infradead.org>; Tue, 12 Jan 2016 20:35:35 -0800 (PST)
Subject: Re: [PATCH RFC V2 1/2] arm64: Add enable/disable d-cache support for
 purgatory
References: <cover.1452572612.git.panand@redhat.com>
 <5679d4baaa5e644f8302982c6f468214ed3d3f3d.1452572612.git.panand@redhat.com>
 <5694BAA1.8000607@linaro.org> <20160112095342.GJ21206@dhcppc13.redhat.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <5695D40F.5030601@linaro.org>
Date: Wed, 13 Jan 2016 13:35:27 +0900
MIME-Version: 1.0
In-Reply-To: <20160112095342.GJ21206@dhcppc13.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org, horms@verge.net.au, james.morse@arm.com, jk@ozlabs.org, scottwood@freescale.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

On 01/12/2016 06:53 PM, Pratyush Anand wrote:
> Hi Akashi,
>
> Thanks for your review.
>
> On 12/01/2016:05:34:41 PM, AKASHI Takahiro wrote:
>>> +	default:
>>> +		return 32;
>>
>> AA64MMFR0_PRANGE_32, instead of 'default', should explicitly be used here
>> as it is defined as 0x0 in ARM ARM.
>
> OK.
>
>>
>>> +static void init_page_table(void)
>>> +{
>>> +	inval_cache_range((uint64_t)page_table,
>>> +				(uint64_t)page_table + PAGE_TABLE_SIZE);
>>> +	memset(page_table, 0, PAGE_TABLE_SIZE);
>>
>> why invalidate first?
>
> Humm..may be you are right. It was copied from arch/arm64/kernel/head.S.
> http://lxr.free-electrons.com/source/arch/arm64/kernel/head.S#L322
>
>>
>>> + */
>>> +static void create_identity_mapping(uint64_t start, uint64_t end,
>>> +					uint64_t flags)
>>> +{
>>> +	uint32_t sec_shift, pgdir_shift, sec_mask;
>>> +	uint64_t desc, s1, e1, s2, e2;
>>> +	uint64_t *table2;
>>> +
>>> +	s1 = start;
>>> +	e1 = end;
>>> +
>>> +	sec_shift = get_section_shift();
>>> +	if (pgtable_level == 1) {
>>> +		s1 >>= sec_shift;
>>> +		e1 >>= sec_shift;
>>> +		do {
>>> +			desc = s1 << sec_shift;
>>> +			desc |= flags;
>>> +			page_table[s1] = desc;
>>> +			s1++;
>>> +		} while (s1 <= e1);
>>
>> To be precise, this loop creates an unnecessary entry
>> if 'end' is exclusive. Pls think about the case that end is
>> on sector boundary. Maybe,
>>      e1 = (e1 - 1) >> sec_shift
>
> Correct.
>
>>
>>> +	} else {
>>> +		pgdir_shift = get_pgdir_shift();
>>> +		sec_mask = get_section_mask();
>>> +		s1 >>= pgdir_shift;
>>> +		e1 >>= pgdir_shift;
>>> +		do {
>>> +			/*
>>> +			 * If there is no table entry then write a new
>>> +			 * entry else, use old entry
>>> +			 */
>>> +			if (!page_table[s1]) {
>>
>> s1 can be larger than 0, 1 or 2 if ram is located at much higher address
>> than the first (three) sector(s).
>
> Yes, that can most likely be, but code will take care.
>  From page_table[0] to page_table[MAX_PAGE_SIZE / sizeof(uint64_t)] will have entries
> for 1st table.
>
> we can have at max three tables.
>
> table1 points to &page_table[0]
> table2 points to &page_table[ MAX_PAGE_SIZE / sizeof(uint64_t)]
> table3 points to &page_table[ 2 * MAX_PAGE_SIZE / sizeof(uint64_t)]
>
> each table can contain number of entries = MAX_PAGE_SIZE / sizeof(uint64_t), so
> if s1  > 3, it should work fine.

OK. I mistakenly recognized that page_table was something like
     uint64_t page_table[3][MAX_PAGE_SIZE/sizeof(uint64_t)]

-Takahiro AKASHI

>>
>>> +static void enable_mmu_dcache(void)
>>> +{
>>> +	uint64_t tcr_flags = TCR_FLAGS | TCR_T0SZ(va_bits);
>>> +
>>> +	switch(page_shift) {
>>> +	case 16:
>>> +		tcr_flags |= TCR_TG0_64K;
>>> +		break;
>>> +	case 12:
>>> +		tcr_flags |= TCR_TG0_4K;
>>> +		break;
>>> +	default:
>>> +		printf("page shift not supported\n");
>>> +		return;
>>> +	}
>>> +	/*
>>> +	 * Since the page tables have been populated with non-cacheable
>>> +	 * accesses (MMU disabled), invalidate the idmap page
>>> +	 * tables again to remove any speculatively loaded cache lines.
>>> +	 */
>>> +	inval_cache_range((uint64_t)page_table,
>>> +				(uint64_t)page_table + PAGE_TABLE_SIZE);
>>> +
>>> +	switch(get_current_el()) {
>>> +	case 3:
>>
>> Linux kernel should be started only in EL2 or non-secure EL1.
>> why should we take care of el3?
>
> I was not sure about it, so kept it. OK.. Will remove in next version.
>
>>
>>> +void disable_dcache(uint64_t ram_start, uint64_t ram_end)
>>> +{
>>> +	switch(get_current_el()) {
>>> +	case 3:
>>> +		reset_sctlr_el3();
>>> +		break;
>>
>> ditto
>
> OK.
>
>>
>>> +#define ID_AA64MMFR0_PARANGE_40		0x2
>>> +#define ID_AA64MMFR0_PARANGE_36		0x1
>>> +#define ID_AA64MMFR0_PARANGE_32		0x0
>>> +
>>> +#define TCR_TG0_64K 		(1UL << 14)
>>> +#define TCR_TG0_4K 		(0UL << 14)
>>> +#define TCR_SHARED_NONE		(0UL << 12)
>>> +#define TCR_ORGN_WBWA		(1UL << 10)
>>> +#define TCR_IRGN_WBWA		(1UL << 8)
>>> +#define TCR_IPS_EL1_SHIFT	32
>>> +#define TCR_IPS_EL2_SHIFT	16
>>> +#define TCR_IPS_EL3_SHIFT	16
>>
>> TCR_PS_EL[23]_SHIFT?
>
> OK :-) , Did not noticed it earlier.
>
> ~Pratyush
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
