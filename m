Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE507C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hg4jHtFPptD11IKNHb8tzWR0GO2U0WDOaH7uUbGPy9g=; b=kCn3BRND8JH+wC
	9jm0fasZUndnF4ua5GJmq5+Mt9zA50F89Vodn1w5etOIfGwzncoQKOVe1gfIEpdBoxYGg93HB9gwZ
	rXND/9XMYTXIQLNtbeAGsOpFkzw+cInO7PETH16fyNL5CKjcVxOnRLLtQ+HseTxQt7vHsAEgXmqS3
	wWQvoLFPrUMjgn8hmvMtPHVbbQFYK1CjelmplqIKlJp81H1aEaOvAfArmOHDwwQYMxuYcc2jm8fDU
	ZYBt2Qib7tmxtKTyu2NewzRAV55gXEd4xVp2okrdkN1WXtyAkch8h1IGCNZnmX3j0UD1jra1Q/Vez
	Vyg5VF5FXSytU0jQDSVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbUS-00000004Ui4-4C6y;
	Mon, 10 Jun 2024 09:39:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbUP-00000004UhS-1zsX
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 09:38:58 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A9SbpN005630
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=l
	mgSA/sSObRBndHj/0OhF0q+wny3GvxW40Q6mGU4PlE=; b=qr3VXkgXEw5pl2U2J
	R5AdDH0UHlZl262vR6ocNUKrzIOhk7+XfcnQ022GU28YxoKWIqDEzR1aIsC1mbf9
	AxDakhow1JyuhiiWYHhgrF1Irf3jwVxHaquliamdndJuMYTHgSeOcjAncaPVaHn9
	QWSssOYl5y5JJOnznximp1ZQ+KO/zxjIf5t3YwTacU7BlNHO1f9wQuw1Kn4tPJ3H
	PeYEVV2db+Qw7n4O8fadqoVGQAe430MXXvzCEF+lzbWx7gdXPvDqMfgI0O8ES/bC
	A/WFBWhCOzJaH+CaN0WbqJHgEniUWxOgZk7CvDd0gNdMd+F2CSY3eiD62ZKrN2jA
	+gSAQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxvs010r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:38:56 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45A9ZN1Z017424
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:38:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxvs010n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:38:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45A9cn8V028690;
	Mon, 10 Jun 2024 09:38:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mty0jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:38:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45A9cn1I33948380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 09:38:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 636A22004D;
	Mon, 10 Jun 2024 09:38:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E006220043;
	Mon, 10 Jun 2024 09:38:47 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 09:38:47 +0000 (GMT)
Message-ID: <f7f398bc-c926-48f6-8b7f-d379d7850667@linux.ibm.com>
Date: Mon, 10 Jun 2024 15:08:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc/kexec_load: add hotplug support
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
 <20240522131353.198327-2-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240522131353.198327-2-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jBlA8c9_9euFAvE093N12qVhpuhh529g
X-Proofpoint-GUID: piG5uMz03luB4pyWN548TYM5umG6jTr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_023857_706297_53E7F64F 
X-CRM114-Status: GOOD (  43.11  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 22/05/24 6:43 pm, Sourabh Jain wrote:
> Kernel commits b741092d5976 ("powerpc/crash: add crash CPU hotplug
> support") and 849599b702ef ("powerpc/crash: add crash memory hotplug
> support") added crash CPU/Memory hotplug support on PowerPC. This patch
> extends that support for the kexec_load syscall.
> 
> During CPU/Memory hotplug events on PowerPC, two kexec segments,
> elfcorehdr, and FDT, get updated by the kernel. To ensure the kernel
> can safely update these two kexec segments for the kdump image loaded
> using the kexec_load system call, the following changes are made:
> 
> 1. Extra size is allocated for both elfcorehdr and FDT to accommodate
>     additional resources in the future. For the elfcorehdr, the size hint
>     is taken from /sys/kernel/crash_elfcorehdr_size sysfs, while for FDT,
>     extra size is allocated to hold possible CPU nodes.
> 
> 2. Both elfcorehdr and FDT are skipped from SHA calculation.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   kexec/arch/ppc64/crashdump-ppc64.c  |  16 ++-
>   kexec/arch/ppc64/fdt.c              | 200 +++++++++++++++++++++++++++-
>   kexec/arch/ppc64/include/arch/fdt.h |   2 +-
>   kexec/arch/ppc64/kexec-elf-ppc64.c  |   2 +-
>   kexec/arch/ppc64/kexec-ppc64.c      |  12 +-
>   5 files changed, 225 insertions(+), 7 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index 6d47898..c14b593 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -476,7 +476,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>   				uint64_t max_addr, unsigned long min_base)
>   {
>   	void *tmp;
> -	unsigned long sz;
> +	unsigned long sz, memsz;
>   	uint64_t elfcorehdr;
>   	int nr_ranges, align = 1024, i;
>   	unsigned long long end;
> @@ -531,8 +531,18 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>   		}
>   	}
>   
> -	elfcorehdr = add_buffer(info, tmp, sz, sz, align, min_base,
> -				max_addr, 1);
> +	memsz = sz;
> +	/* To support --hotplug, replace the calculated minimum size with the
> +	 * value from /sys/kernel/crash_elfcorehdr_size and align it correctly.
> +	 */
> +	if (do_hotplug) {
> +		if (elfcorehdrsz > sz)
> +			memsz = _ALIGN(elfcorehdrsz, align);
> +	}
> +
> +	/* Record the location of the elfcorehdr for hotplug handling */
> +	info->elfcorehdr = elfcorehdr = add_buffer(info, tmp, sz, memsz, align,
> +						   min_base, max_addr, 1);
>   	reserve(elfcorehdr, sz);
>   	/* modify and store the cmdline in a global array. This is later
>   	 * read by flatten_device_tree and modified if required
> diff --git a/kexec/arch/ppc64/fdt.c b/kexec/arch/ppc64/fdt.c
> index 8bc6d2d..10abc29 100644
> --- a/kexec/arch/ppc64/fdt.c
> +++ b/kexec/arch/ppc64/fdt.c
> @@ -17,6 +17,13 @@
>   #include <libfdt.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <dirent.h>
> +#include <sys/stat.h>
> +
> +#include "../../kexec.h"
> +#include "../../kexec-syscall.h"
>   
>   /*
>    * Let the kernel know it booted from kexec, as some things (e.g.
> @@ -46,17 +53,208 @@ static int fixup_kexec_prop(void *fdt)
>   	return 0;
>   }
>   
> +static inline bool is_dot_dir(char * d_path)
> +{
> +	return d_path[0] == '.';
> +}
> +
> +/*
> + * Returns size of files including file name size under the given
> + * @cpu_node_path.
> + */
> +static unsigned int get_cpu_node_size(char *cpu_node_path)
> +{
> +	DIR *d;
> +	struct dirent *de;
> +	struct stat statbuf;
> +	unsigned int cpu_node_size = 0;
> +	char cpu_prop_path[2 * PATH_MAX];
> +
> +	d = opendir(cpu_node_path);
> +	if (!d)
> +		return 0;
> +
> +	while ((de = readdir(d)) != NULL) {
> +		if (de->d_type != DT_REG)
> +			continue;
> +
> +		memset(cpu_prop_path, '\0', PATH_MAX);
> +		snprintf(cpu_prop_path, 2 * PATH_MAX, "%s/%s", cpu_node_path, de->d_name);
> +
> +		if (stat(cpu_prop_path, &statbuf))
> +			continue;
> +
> +		cpu_node_size += statbuf.st_size;
> +		cpu_node_size += strlen(de->d_name);
> +	}
> +
> +	return cpu_node_size;
> +}
> +
> +/*
> + * Checks if the node specified by the given @path represents a CPU node.
> + *
> + * Returns true if the @path has a "device_type" file containing "cpu";
> + * otherwise, returns false.
> + */
> +static bool is_cpu_node(char *path)
> +{
> +	FILE *file;
> +	bool ret = false;
> +	char device_type[4];
> +
> +	file = fopen(path, "r");
> +	if (!file)
> +		return false;
> +
> +	memset(device_type, '\0', 4);
> +	if (fread(device_type, 1, 3, file) < 3)
> +		goto out;
> +
> +	if (strcmp(device_type, "cpu"))
> +		goto out;
> +
> +	ret = true;
> +
> +out:
> +	fclose(file);
> +	return ret;
> +}
> +
> +static unsigned int get_threads_per_cpu(char *path)
> +{
> +	struct stat statbuf;
> +	if (stat(path, &statbuf))
> +		return 0;
> +
> +	return statbuf.st_size / 4;
> +}
> +
> +/*
> + * Finds the following CPU attributes:
> + *
> + * cpus_in_system: Currently available CPU nodes present under
> + *                 /proc/device-tree/cpus.
> + * threads_per_cpu: Number of threads per CPU, based on the device tree entry
> + *                  /proc/device-tree/cpus/<cpu_node>/ibm,ppc-interrupt-server#s.
> + * cpu_node_size: Size of files including file name size under a CPU node.
> + *
> + * Returns 0 on success, else -1.
> + */
> +static unsigned int get_cpu_info(int *_cpus_in_system, int *_threads_per_cpu,
> +				 int *_cpu_node_size)
> +{
> +	DIR *d;
> +	struct dirent *de;
> +	int first_cpu = 1;
> +	char path[PATH_MAX];
> +	char *cpus_node_path = "/proc/device-tree/cpus";
> +	int cpus_in_system = 0, threads_per_cpu = 0, cpu_node_size = 0;
> +
> +	d = opendir(cpus_node_path);
> +	if (!d)
> +		return -1;
> +
> +	while ((de = readdir(d)) != NULL) {
> +		if ((de->d_type != DT_DIR) || is_dot_dir(de->d_name))
> +			continue;
> +
> +		memset(path, '\0', PATH_MAX);
> +		snprintf(path, PATH_MAX, "%s/%s/%s", cpus_node_path,
> +			 de->d_name, "device_type");
> +
> +		/* Skip nodes with device_type != "cpu" */
> +		if (!is_cpu_node(path))
> +			continue;
> +
> +		/*
> +		 * Found the first node under /proc/device-tree/cpus with
> +		 * device_type == "cpu"
> +		 */
> +		if (first_cpu) {
> +			memset(path, '\0', PATH_MAX);
> +			snprintf(path, PATH_MAX, "%s/%s", cpus_node_path, de->d_name);
> +			cpu_node_size = get_cpu_node_size(path);
> +
> +			memset(path, '\0', PATH_MAX);
> +			snprintf(path, PATH_MAX, "%s/%s/%s", cpus_node_path,
> +				 de->d_name, "ibm,ppc-interrupt-server#s");
> +			threads_per_cpu = get_threads_per_cpu(path);
> +
> +			first_cpu = 0;
> +		}
> +
> +		cpus_in_system++;
> +	}
> +
> +	closedir(d);
> +
> +	dbgprintf("cpus_in_system: %d, threads_per_cpus: %d, cpu_node_size: %d\n",
> +		  cpus_in_system, threads_per_cpu, cpu_node_size);
> +
> +	if (!(cpus_in_system && threads_per_cpu && cpu_node_size))
> +		return -1;
> +
> +	*_cpus_in_system = cpus_in_system;
> +	*_threads_per_cpu = threads_per_cpu;
> +	*_cpu_node_size = cpu_node_size;
> +
> +	return 0;
> +}
> +
> +/*
> + * Calculates the extra size needed for the flattened device tree (FDT) based
> + * on the difference between the possible number of CPU nodes and the number
> + * of CPU nodes present under /proc/device-tree/cpus.
> + */
> +static unsigned int kdump_fdt_extra_size(void)
> +{
> +	unsigned int extra_size = 0;
> +	int cpus_in_system = 0, threads_per_cpu = 0, cpu_node_size = 0;
> +	int possible_cpus;
> +
> +	/* ALL possible CPUs are present in FDT so no extra size required */
> +	if (sysconf(_SC_NPROCESSORS_ONLN) == sysconf(_SC_NPROCESSORS_CONF))
> +		return 0;
> +
> +	if (get_cpu_info(&cpus_in_system, &threads_per_cpu, &cpu_node_size)) {

Is (sysconf(_SC_NPROCESSORS_ONLN) / threads_per_cpu) not the same as
'cpus_in_system'? If they are same, should be able to get cpu_node_size
& threads_per_cpu by examining a single core instead of going through
all cores on the system??

> +		die("Failed to get cpu info\n");
> +	}
> +
> +	/*
> +	 * Maximum number of CPU nodes with device_type = "cpu" possible under
> +	 * /proc/device-tree/cpus/
> +	 */
> +	possible_cpus = sysconf(_SC_NPROCESSORS_CONF) / threads_per_cpu;
> +
> +	if (cpus_in_system > possible_cpus)
> +		die("Possible CPU nodes can't be less than active CPU nodes\n");
> +
> +
> +	extra_size = (possible_cpus - cpus_in_system) * cpu_node_size;
> +	dbgprintf("kdump fdt extra size: %u\n", extra_size);
> +
> +	return extra_size;
> +}
>   
>   /*
>    * For now, assume that the added content fits in the file.
>    * This should be the case when flattening from /proc/device-tree,
>    * and when passing in a dtb, dtc can be told to add padding.
>    */
> -int fixup_dt(char **fdt, off_t *size)
> +int fixup_dt(char **fdt, off_t *size, unsigned long kexec_flags)
>   {
>   	int ret;
>   
>   	*size += 4096;
> +
> +	/* To support --hotplug option for the kexec_load syscall, consider
> +	 * adding extra buffer to FDT so that the kernel can add CPU nodes
> +	 * of hot-added CPUs.
> +	 */
> +	if (do_hotplug && (kexec_flags & KEXEC_ON_CRASH))
> +		*size += kdump_fdt_extra_size();
> +
>   	*fdt = realloc(*fdt, *size);
>   	if (!*fdt) {
>   		fprintf(stderr, "%s: out of memory\n", __func__);
> diff --git a/kexec/arch/ppc64/include/arch/fdt.h b/kexec/arch/ppc64/include/arch/fdt.h
> index b19f185..5f340b0 100644
> --- a/kexec/arch/ppc64/include/arch/fdt.h
> +++ b/kexec/arch/ppc64/include/arch/fdt.h
> @@ -3,6 +3,6 @@
>   
>   #include <sys/types.h>
>   
> -int fixup_dt(char **fdt, off_t *size);
> +int fixup_dt(char **fdt, off_t *size, unsigned long kexec_flags);
>   
>   #endif
> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> index bdcfd20..858c994 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> @@ -345,7 +345,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>   		create_flatten_tree(&seg_buf, &seg_size, cmdline);
>   	}
>   
> -	result = fixup_dt(&seg_buf, &seg_size);
> +	result = fixup_dt(&seg_buf, &seg_size, info->kexec_flags);
>   	if (result < 0)
>   		return result;
>   
> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> index fb27b6b..f27d76b 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-ppc64.c
> @@ -24,6 +24,7 @@
>   #include <errno.h>
>   #include <stdint.h>
>   #include <string.h>
> +#include <libfdt.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <dirent.h>
> @@ -968,7 +969,16 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
>   
> -int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
>   {

> +	if (!seg_ptr)

When can this be true? If this is a possiblilty, why do we not have the
same thing for i386?

- Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
