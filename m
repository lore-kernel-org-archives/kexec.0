Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KFoZK-00056o-Ej
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 11:07:43 +0000
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m67B7bCN002031 for <kexec@lists.infradead.org> (envelope-from
	takebe_akio@jp.fujitsu.com); Mon, 7 Jul 2008 20:07:38 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CBA7F1B801E
	for <kexec@lists.infradead.org>; Mon,  7 Jul 2008 20:07:37 +0900 (JST)
Received: from s8.gw.fujitsu.co.jp (s8.gw.fujitsu.co.jp [10.0.50.98])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A38842DC015
	for <kexec@lists.infradead.org>; Mon,  7 Jul 2008 20:07:37 +0900 (JST)
Received: from s8.gw.fujitsu.co.jp (s8 [127.0.0.1])
	by s8.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B7271818028
	for <kexec@lists.infradead.org>; Mon,  7 Jul 2008 20:07:37 +0900 (JST)
Received: from fjm506.ms.jp.fujitsu.com (fjm506.ms.jp.fujitsu.com
	[10.56.99.86])
	by s8.gw.fujitsu.co.jp (Postfix) with ESMTP id 31BB91818027
	for <kexec@lists.infradead.org>; Mon,  7 Jul 2008 20:07:37 +0900 (JST)
Received: from fjmscan503.ms.jp.fujitsu.com (fjmscan503.ms.jp.fujitsu.com
	[10.56.99.143])by fjm506.ms.jp.fujitsu.com with ESMTP id
	m67B78Yc024596
	for <kexec@lists.infradead.org>; Mon, 7 Jul 2008 20:07:08 +0900
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [makedumpfile][PATCH] handle x86_64 xen code/data relocation
Date: Mon, 07 Jul 2008 20:07:03 +0900
MIME-Version: 1.0
In-Reply-To: <4871D286.3010306@mxs.nes.nec.co.jp>
References: <20080704091014.EEC7.ODA@valinux.co.jp>
	<4871D286.3010306@mxs.nes.nec.co.jp>
Message-Id: <5EC8E021963406takebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Itsuro ODA <oda@valinux.co.jp>
Cc: Akio Takebe <takebe_akio@jp.fujitsu.com>, kexec@lists.infradead.org

Hi, Ohmichi-san, Oda-san

I'm sorry for my late response,
and thank you for your work so much!

Best Regards,

Akio Takebe

>
>Hi ODA-san,
>
>I tested your patch on RHEL5.2 (based on xen-3.1.2).
>If both your patch and Takebe-san's patch ([1]) are applied to makedumpfile,
>it can work fine. Thank you so much.
>
>I will merge them into the next release.
>
>
>Thanks
>Ken'ichi Ohmichi
>
>[1]: [RFC] makedumpfile: fix for xen-3.1.2
>     http://lists.infradead.org/pipermail/kexec/2008-April/001533.html
>
>
>Itsuro ODA wrote:
>> Hi all,
>> 
>> Recent version of xen (ex. RHEL5.2, 3.2.0) on the x86_64
>> moves the physical(machine) address of xen code/data area after 
>> the system started up. The start address of this is stored in
>> 'xen_phys_start'. Thus to get a machine address of a xen text symbol
>> from its virtual address, calculate 
>> "va - __XEN_VIRT_START +  xen_phys_start".
>> 
>> makedumpfile command need the value of xen_phys_start.
>> They know the virtual address of 'xen_phys_start' symbol but
>> no way to extract the value of xen_phys_start.
>> 
>> I posted a patch which adds the xen_phys_start value to the 
>> CRASHINFO ElfNote section and It was merged the upstream (xen-unstable
>> tree).
>> 
>> This patch enables as follows:
>> * add --xen_phys_start option for a vmcore which is relocated and does not
>>   include the xen_phys_start value in the CRASHINFO.
>> * extract the xen_phys_start value from the CRASHINFO if the CRASHINFO
>>   includes the xen_phys_start value.
>> 
>> (note that the crash command includes this function already.)
>> 
>> This patch is for makedumpfile-1.2.6.
>> 
>> Thanks.
>> Itsuro Oda
>> 
>> ---
>> --- makedumpfile.h.org	2008-06-12 15:25:43.000000000 +0900
>> +++ makedumpfile.h	2008-07-03 10:48:07.000000000 +0900
>> @@ -467,6 +467,7 @@ do { \
>>  #define STRLEN_OSRELEASE (65)	/* same length as diskdump.h */
>>  
>>  #define XEN_ELFNOTE_CRASH_INFO	(0x1000001)
>> +#define SIZE_XEN_CRASH_INFO_V2	(sizeof(unsigned long) * 10)
>>  
>>  /*
>>   * The value of dependence on machine
>> @@ -778,6 +779,9 @@ struct DumpInfo {
>>  	/*
>>  	 * for Xen extraction
>>  	 */
>> +	off_t			offset_xen_crash_info;
>> +	unsigned long		size_xen_crash_info;
>> +	unsigned long xen_phys_start;
>>  	unsigned long xen_heap_start;	/* start mfn of xen heap area */
>>  	unsigned long xen_heap_end;	/* end mfn(+1) of xen heap area */
>>  	unsigned long frame_table_vaddr;
>> @@ -1051,11 +1055,14 @@ int get_xen_info_x86();
>>  #define HYPERVISOR_VIRT_END   (0xffff880000000000)
>>  #define DIRECTMAP_VIRT_START  (0xffff830000000000)
>>  #define DIRECTMAP_VIRT_END    (0xffff840000000000)
>> +#define XEN_VIRT_START        (0xffff828c80000000)
>>  
>>  #define is_xen_vaddr(x) \
>>          ((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
>>  #define is_direct(x) \
>>          ((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
>> +#define is_xen_text(x) \
>> +        ((x) >= XEN_VIRT_START && (x) < DIRECTMAP_VIRT_START)
>>  
>>  unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
>>  #define kvtop_xen(X)	kvtop_xen_x86_64(X)
>> --- makedumpfile.c.org	2008-06-12 15:01:26.000000000 +0900
>> +++ makedumpfile.c	2008-07-03 12:02:44.000000000 +0900
>> @@ -2187,6 +2187,8 @@ read_vmcoreinfo_basic_info()
>>  
>>  	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>  		i = strlen(buf);
>> +		if (!i)
>> +			break;
>>  		if (buf[i - 1] == '\n')
>>  			buf[i - 1] = '\0';
>>  		if (strncmp(buf, STR_OSRELEASE, strlen(STR_OSRELEASE)) == 0) {
>> @@ -2244,6 +2246,8 @@ read_vmcoreinfo_symbol(char *str_symbol)
>>  
>>  	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>  		i = strlen(buf);
>> +		if (!i)
>> +			break;
>>  		if (buf[i - 1] == '\n')
>>  			buf[i - 1] = '\0';
>>  		if (strncmp(buf, str_symbol, strlen(str_symbol)) == 0) {
>> @@ -2275,6 +2279,8 @@ read_vmcoreinfo_long(char *str_structure
>>  
>>  	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>  		i = strlen(buf);
>> +		if (!i)
>> +			break;
>>  		if (buf[i - 1] == '\n')
>>  			buf[i - 1] = '\0';
>>  		if (strncmp(buf, str_structure, strlen(str_structure)) == 0) {
>> @@ -2304,6 +2310,8 @@ read_vmcoreinfo_string(char *str_in, cha
>>  
>>  	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>  		i = strlen(buf);
>> +		if (!i)
>> +			break;
>>  		if (buf[i - 1] == '\n')
>>  			buf[i - 1] = '\0';
>>  		if (strncmp(buf, str_in, strlen(str_in)) == 0) {
>> @@ -2467,8 +2475,20 @@ get_pt_note_info(off_t off_note, unsigne
>>  		/*
>>  		 * Check whether /proc/vmcore contains xen's note.
>>  		 */
>> -		} else if (n_type == XEN_ELFNOTE_CRASH_INFO)
>> +		} else if (n_type == XEN_ELFNOTE_CRASH_INFO) {
>>  			vt.mem_flags |= MEMORY_XEN;
>> +			if (info->flag_elf64) {
>> +				info->offset_xen_crash_info = offset
>> +				    + (sizeof(note64)
>> +				    + ((note64.n_namesz + 3) & ~3));
>> +				info->size_xen_crash_info = note64.n_descsz;
>> +			} else {
>> +				info->offset_xen_crash_info = offset
>> +				    + (sizeof(note32)
>> +				    + ((note32.n_namesz + 3) & ~3));
>> +				info->size_xen_crash_info = note32.n_descsz;
>> +			}
>> +		}
>>  
>>  		if (info->flag_elf64) {
>>  			offset += sizeof(Elf64_Nhdr)
>> @@ -5547,6 +5567,36 @@ get_structure_info_xen()
>>  }
>>  
>>  int
>> +get_xen_phys_start(void)
>> +{
>> +	off_t offset;
>> +	unsigned long xen_phys_start;
>> +	const off_t failed = (off_t)-1;
>> +
>> +	if (info->xen_phys_start)
>> +		return TRUE;
>> +
>> +	if (info->size_xen_crash_info >= SIZE_XEN_CRASH_INFO_V2) {
>> +		offset = info->offset_xen_crash_info + info->
>> size_xen_crash_info
>> +			 - sizeof(unsigned long) * 2;
>> +		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
>> +			ERRMSG("Can't seek the dump memory(%s). %s\n",
>> +			    info->name_memory, strerror(errno));
>> +			return FALSE;
>> +		}
>> +		if (read(info->fd_memory, &xen_phys_start, sizeof(unsigned 
>> long))
>> +		    != sizeof(unsigned long)) {
>> +			ERRMSG("Can't read the dump memory(%s). %s\n",
>> +			    info->name_memory, strerror(errno));
>> +			return FALSE;
>> +		}
>> +		info->xen_phys_start = xen_phys_start;
>> +	}
>> +
>> +	return TRUE;
>> +}
>> +
>> +int
>>  get_xen_info()
>>  {
>>  	unsigned long domain;
>> @@ -5706,6 +5756,7 @@ show_data_xen()
>>  	MSG("OFFSET(domain.next_in_list): %ld\n", OFFSET(domain.
>> next_in_list));
>>  
>>  	MSG("\n");
>> +	MSG("xen_phys_start: %lx\n", info->xen_phys_start);
>>  	MSG("frame_table_vaddr: %lx\n", info->frame_table_vaddr);
>>  	MSG("xen_heap_start: %lx\n", info->xen_heap_start);
>>  	MSG("xen_heap_end:%lx\n", info->xen_heap_end);
>> @@ -5790,6 +5841,8 @@ read_vmcoreinfo_basic_info_xen()
>>  
>>  	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>  		i = strlen(buf);
>> +		if (!i)
>> +			break;
>>  		if (buf[i - 1] == '\n')
>>  			buf[i - 1] = '\0';
>>  		if (strncmp(buf, STR_PAGESIZE, strlen(STR_PAGESIZE)) == 0) {
>> @@ -6023,6 +6076,8 @@ initial_xen()
>>  			return FALSE;
>>  		unlink(info->name_vmcoreinfo);
>>  	}
>> +	if (!get_xen_phys_start())
>> +		return FALSE;
>>  	if (!get_xen_info())
>>  		return FALSE;
>>  
>> @@ -6204,6 +6259,7 @@ check_param_for_creating_dumpfile(int ar
>>  static struct option longopts[] = {
>>  	{"xen-syms", required_argument, NULL, 'y'},
>>  	{"xen-vmcoreinfo", required_argument, NULL, 'z'},
>> +	{"xen_phys_start", required_argument, NULL, 'P'},
>>  	{"message-level", required_argument, NULL, 'm'},
>>  	{"help", no_argument, NULL, 'h'},
>>  	{0, 0, 0, 0}
>> @@ -6266,6 +6322,9 @@ main(int argc, char *argv[])
>>  		case 'm':
>>  			message_level = atoi(optarg);
>>  			break;
>> +		case 'P':
>> +			info->xen_phys_start = strtoul(optarg, NULL, 0);
>> +			break;
>>  		case 'R':
>>  			info->flag_rearrange = 1;
>>  			break;
>> --- x86_64.c.org	2008-06-12 15:16:48.000000000 +0900
>> +++ x86_64.c	2008-07-03 10:58:24.000000000 +0900
>> @@ -190,6 +190,9 @@ kvtop_xen_x86_64(unsigned long kvaddr)
>>  	if (!is_xen_vaddr(kvaddr))
>>  		return NOT_PADDR;
>>  
>> +	if (is_xen_text(kvaddr))
>> +		return (unsigned long)kvaddr - XEN_VIRT_START + info->
>> xen_phys_start;
>> +
>>  	if (is_direct(kvaddr))
>>  		return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
