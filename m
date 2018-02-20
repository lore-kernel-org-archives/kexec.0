Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eoD70-0005bG-G8
 for kexec@lists.infradead.org; Tue, 20 Feb 2018 18:58:00 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1KItVU5048032
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 13:57:46 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g8qtk3yu1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 13:57:45 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 18:57:44 -0000
Subject: Re: [PATCH 2/2] kexec/ppc64: add support to parse ibm,
 dynamic-memory-v2 property
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
References: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
 <151913628939.8893.17231490402797441078.stgit@hbathini.in.ibm.com>
Date: Wed, 21 Feb 2018 00:27:39 +0530
MIME-Version: 1.0
In-Reply-To: <151913628939.8893.17231490402797441078.stgit@hbathini.in.ibm.com>
Content-Language: en-US
Message-Id: <a48462f8-41a8-f819-f9de-0dbef0f70fa5@linux.vnet.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, nfont@linux.vnet.ibm.com



On Tuesday 20 February 2018 07:48 PM, Hari Bathini wrote:
> Add support to parse the new 'ibm,dynamic-memory-v2' property in the
> 'ibm,dynamic-reconfiguration-memory' node. This replaces the old
> 'ibm,dynamic-memory' property and is enabled in the kernel with a
> patch series that starts with commit 0c38ed6f6f0b ("powerpc/pseries:
> Enable support of ibm,dynamic-memory-v2"). All LMBs that share the same
> flags and are adjacent are grouped together in the newer version of the
> property making it compact to represent larger memory configurations.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>   kexec/arch/ppc64/crashdump-ppc64.c |   23 +++++++--
>   kexec/arch/ppc64/crashdump-ppc64.h |   16 +++++-
>   kexec/arch/ppc64/kexec-ppc64.c     |   35 ++++++++++----
>   kexec/fs2dt.c                      |   92 ++++++++++++++++++++++--------------
>   4 files changed, 112 insertions(+), 54 deletions(-)
>
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index bc9f948..50e3853 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -39,6 +39,10 @@
>   #define DEVTREE_CRASHKERNEL_BASE "/proc/device-tree/chosen/linux,crashkernel-base"
>   #define DEVTREE_CRASHKERNEL_SIZE "/proc/device-tree/chosen/linux,crashkernel-size"
>
> +unsigned int num_of_lmb_sets;
> +unsigned int is_dyn_mem_v2;
> +uint64_t lmb_size;
> +
>   static struct crash_elf_info elf_info64 =
>   {
>   	class: ELFCLASS64,
> @@ -127,6 +131,7 @@ static int get_dyn_reconf_crash_memory_ranges(void)
>   {
>   	uint64_t start, end;
>   	uint64_t startrange, endrange;
> +	uint64_t size;
>   	char fname[128], buf[32];
>   	FILE *file;
>   	unsigned int i;
> @@ -135,6 +140,8 @@ static int get_dyn_reconf_crash_memory_ranges(void)
>
>   	strcpy(fname, "/proc/device-tree/");
>   	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
> +	if (is_dyn_mem_v2)
> +		strcat(fname, "-v2");
>   	if ((file = fopen(fname, "r")) == NULL) {
>   		perror(fname);
>   		return -1;
> @@ -142,8 +149,9 @@ static int get_dyn_reconf_crash_memory_ranges(void)
>
>   	fseek(file, 4, SEEK_SET);
>   	startrange = endrange = 0;
> -	for (i = 0; i < num_of_lmbs; i++) {
> -		if ((n = fread(buf, 1, 24, file)) < 0) {
> +	size = lmb_size;
> +	for (i = 0; i < num_of_lmb_sets; i++) {
> +		if ((n = fread(buf, 1, LMB_ENTRY_SIZE, file)) < 0) {
>   			perror(fname);
>   			fclose(file);
>   			return -1;
> @@ -156,8 +164,15 @@ static int get_dyn_reconf_crash_memory_ranges(void)
>   			return -1;
>   		}
>
> -		start = be64_to_cpu(((uint64_t *)buf)[DRCONF_ADDR]);
> -		end = start + lmb_size;
> +		/*
> +		 * If the property is ibm,dynamic-memory-v2, the first 4 bytes
> +		 * tell the number of sequential LMBs in this entry.
> +		 */
> +		if (is_dyn_mem_v2)
> +			size = be32_to_cpu(((unsigned int *)buf)[0]) * lmb_size;
> +
> +		start = be64_to_cpu(*((uint64_t *)&buf[DRCONF_ADDR]));
> +		end = start + size;
>   		if (start == 0 && end >= (BACKUP_SRC_END + 1))
>   			start = BACKUP_SRC_END + 1;
>
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
> index 42ccc31..87beb39 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.h
> +++ b/kexec/arch/ppc64/crashdump-ppc64.h
> @@ -34,10 +34,18 @@ extern unsigned int rtas_size;
>   extern uint64_t opal_base;
>   extern uint64_t opal_size;
>
> -uint64_t lmb_size;
> -unsigned int num_of_lmbs;

This might probably break compilation on other architectures like arm64 
& mips.
Will check and post v2..

- Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
