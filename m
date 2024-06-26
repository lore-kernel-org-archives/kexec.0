Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A431C30653
	for <kexec@archiver.kernel.org>; Wed, 26 Jun 2024 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J7yvc44zqeEhl3IjJI3VDNVsgb7ZtYSxFWx1myOMggs=; b=3drJCF8P8lgZrX
	rUAoV/zRq6VlcduREPzuDdIiXbNLMVuHRva6rzp0uf9s7MjtYhhoictwFnLnF/r3Jidn8MnT5sL6n
	Xw0iubideqaXhaTWkuyGENHF47uR/LeRivdDEtHmQE3gcyblB7W53ZUXqH9NKRZlUmMJGfakojdye
	rTnpr+2h16vmC1VKqxQyMYiGVjb/xfbL3RFxxetV6T8rm0Nz0kCNC0FrXS+utJiBikQIckUMfIcgy
	HT6oZRE3sO134qgmbBNw3zQzGApKiUbyeCuyUrOyi9Nih3DNkFGyJlZD9rOPLrMnAr4db013dS8U9
	IZQvCXBjj6jpl6Ppo25Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMPZZ-00000006F4w-25MZ;
	Wed, 26 Jun 2024 10:08:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMPZV-00000006F4H-0c6v
	for kexec@lists.infradead.org;
	Wed, 26 Jun 2024 10:08:14 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9xXbZ011009;
	Wed, 26 Jun 2024 10:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=u
	aG4I/ViUBjo2vImTIznKsfw3iX/oScH+RGYWC41gHc=; b=VhAn+thGb6JFNT6Ip
	cQ4lvQx5MSWRJKfczWpJat5eMPsO7du4GRt4tGSIjB0c0jhASQsoQI4x5UlTa6ck
	v7D0shw567RB5QMs7w5yTfvYssRFyGQ/DTbrieXiZJNrgLWKbFG+Uc00aC0OX0X9
	KiU81ZIM4oqD3FvldHGWyeHm8DPwz5kumlhJDCvlSsfnEBNN9rrJ7hbUAY83RLmH
	Mn+TweQETOZ8UfWxJLTlJGfhMkxPi6Rq9zUEoNZTrBeT8FCay3ERlKPzDxWiQHXr
	4hlVgqmM1fraYEegLR1EAYMOt1EgMIjk+j+LH2OvvrgLbVd3P69rtQOxz4Xzy7gS
	7I6hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400gu1r0s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:08:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QA875R024170;
	Wed, 26 Jun 2024 10:08:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400gu1r0s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:08:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q7R7RR000397;
	Wed, 26 Jun 2024 10:08:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3b9et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:08:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QA81v245089126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:08:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1C8201DD;
	Wed, 26 Jun 2024 10:08:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6135A201D7;
	Wed, 26 Jun 2024 10:07:59 +0000 (GMT)
Received: from [9.109.222.128] (unknown [9.109.222.128])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 10:07:59 +0000 (GMT)
Message-ID: <e7b302a8-65ff-4fe6-9fee-d086e82f136d@linux.ibm.com>
Date: Wed, 26 Jun 2024 15:37:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powerpc/kexec_load: add hotplug support
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
 <20240613190738.1852258-2-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240613190738.1852258-2-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g_pXbNM10g-bXyH3zGWwUn5SxS8WVrp1
X-Proofpoint-GUID: k8rtvS5wINVs2u5E4lrsco9gSIS9yYOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_04,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_030813_309982_9DE15323 
X-CRM114-Status: GOOD (  39.59  )
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



On 14/06/24 12:37 am, Sourabh Jain wrote:
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
> Cc: Simon Horman <horms@kernel.org>

LGTM.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> 
> Changelog:
> 
> Since v1:
>    - Find CPUs in the system using the /sys/devices/system/cpu/present sysfs
>      instead of traversing all nodes under /proc/device-tree/cpus.
> 
>    - Added a new function to find present CPUs in the system.
> 
>    - Removed unnecessary NULL check on seg_ptr from arch_do_exclude_segment().
> 
> ---
>   kexec/arch/ppc64/crashdump-ppc64.c  |  16 +-
>   kexec/arch/ppc64/fdt.c              | 236 +++++++++++++++++++++++++++-
>   kexec/arch/ppc64/include/arch/fdt.h |   2 +-
>   kexec/arch/ppc64/kexec-elf-ppc64.c  |   2 +-
>   kexec/arch/ppc64/kexec-ppc64.c      |   9 +-
>   5 files changed, 258 insertions(+), 7 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index 6d47898..98d439a 100644
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
> +	/* To support --hotplug, replace the calculated memsz with the value
> +	 * from /sys/kernel/crash_elfcorehdr_size and align it correctly.
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
> index 8bc6d2d..879240f 100644
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
> @@ -46,17 +53,244 @@ static int fixup_kexec_prop(void *fdt)
>   	return 0;
>   }
>   
> +static inline bool is_dot_dir(char * d_path)
> +{
> +	return d_path[0] == '.';
> +}
> +
> +/*
> + * get_cpu_node_size - Returns size of files including file name size under
> + *                     the given @cpu_node_path.
> + */
> +static int get_cpu_node_size(char *cpu_node_path)
> +{
> +	DIR *d;
> +	struct dirent *de;
> +	struct stat statbuf;
> +	int cpu_node_size = 0;
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
> +		snprintf(cpu_prop_path, 2 * PATH_MAX, "%s/%s", cpu_node_path,
> +			 de->d_name);
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
> + * is_cpu_node - Checks if the node specified by the given @path
> + *               represents a CPU node.
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
> +out:
> +	fclose(file);
> +	return ret;
> +}
> +
> +static int get_threads_per_cpu(char *path)
> +{
> +	struct stat statbuf;
> +	if (stat(path, &statbuf))
> +		return 0;
> +
> +	return statbuf.st_size / 4;
> +}
> +
> +/**
> + * get_present_cpus - finds the present CPUs in the system
> + *
> + * This function opens the file `/sys/devices/system/cpu/present` to read
> + * the range of present CPUs. It parses the range and calculates the
> + * total number of present CPUs in the system.
> + *
> + * Returns total number of present CPUs on success, -1 on failure.
> + */
> +static int get_present_cpus()
> +{
> +	char *range;
> +	char buf[1024];
> +	int start, end;
> +	int cpu_count = 0;
> +	FILE *file = fopen("/sys/devices/system/cpu/present", "r");
> +
> +	if (!file)
> +		return -1;
> +
> +	if (!fgets(buf, sizeof(buf), file))
> +		return -1;
> +
> +	fclose(file);
> +
> +	range = strtok(buf, ",");
> +	while (range != NULL) {
> +		if (sscanf(range, "%d-%d", &start, &end) == 2) {
> +			for (int i = start; i <= end; i++)
> +				cpu_count++;
> +		} else if (sscanf(range, "%d", &start) == 1) {
> +			cpu_count++;
> +		} else {
> +			return -1;
> +		}
> +		range = strtok(NULL, ",");
> +	}
> +
> +	return cpu_count;
> +}
> +
> +/*
> + * get_cpu_info - Finds the following CPU attributes:
> + *
> + * threads_per_cpu: Number of threads per CPU, based on the device tree entry
> + *                  /proc/device-tree/cpus/<cpu_node>/ibm,ppc-interrupt-server#s.
> + * cpu_node_size: Size of files including file name size under a CPU node.
> + *
> + * Returns 0 on success, else -1.
> + */
> +static int get_cpu_info(int *_present_cpus, int *_threads_per_cpu, int *_cpu_node_size)
> +{
> +	DIR *d;
> +	struct dirent *de;
> +	char path[PATH_MAX];
> +	int present_cpus = 0, threads_per_cpu = 0, cpu_node_size = 0;
> +	char *cpus_node_path = "/proc/device-tree/cpus";
> +
> +	present_cpus = get_present_cpus();
> +	if (present_cpus < 0)
> +		return -1;
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
> +		memset(path, '\0', PATH_MAX);
> +		snprintf(path, PATH_MAX, "%s/%s", cpus_node_path, de->d_name);
> +		cpu_node_size = get_cpu_node_size(path);
> +
> +		memset(path, '\0', PATH_MAX);
> +		snprintf(path, PATH_MAX, "%s/%s/%s", cpus_node_path,
> +		de->d_name, "ibm,ppc-interrupt-server#s");
> +		threads_per_cpu = get_threads_per_cpu(path);
> +		break;
> +	}
> +
> +	closedir(d);
> +
> +	if (!(threads_per_cpu && cpu_node_size))
> +		return -1;
> +
> +	*_present_cpus = present_cpus;
> +	*_cpu_node_size = cpu_node_size;
> +	*_threads_per_cpu = threads_per_cpu;
> +
> +	dbgprintf("present_cpus: %d, threads_per_cpu: %d, cpu_node_size: %d\n",
> +		  present_cpus, threads_per_cpu, cpu_node_size);
> +
> +	return 0;
> +}
> +
> +/*
> + * kdump_fdt_extra_size - Calculates the extra size needed for the Flattened
> + *                        Device Tree (FDT) based on the possible and present
> + *                        CPUs in the system.
> + */
> +static unsigned int kdump_fdt_extra_size(void)
> +{
> +	int cpus_in_system;
> +	unsigned int extra_size = 0;
> +	int present_cpus = 0, threads_per_cpu = 0, cpu_node_size = 0;
> +	int possible_cpus;
> +
> +	/* ALL possible CPUs are present in FDT so no extra size required */
> +	if (sysconf(_SC_NPROCESSORS_ONLN) == sysconf(_SC_NPROCESSORS_CONF))
> +		return 0;
> +
> +	if (get_cpu_info(&present_cpus, &threads_per_cpu, &cpu_node_size)) {
> +		die("Failed to get cpu info\n");
> +	}
> +
> +	cpus_in_system = present_cpus / threads_per_cpu;
> +	possible_cpus = sysconf(_SC_NPROCESSORS_CONF) / threads_per_cpu;
> +	dbgprintf("cpus_in_system: %d, possible_cpus: %d\n", cpus_in_system,
> +		  possible_cpus);
> +
> +	if (cpus_in_system > possible_cpus)
> +		die("Possible CPU nodes can't be less than active CPU nodes\n");
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
> index fb27b6b..13c3ce3 100644
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
> @@ -968,7 +969,13 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
>   
> -int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
>   {
> +	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
> +		return 1;
> +
> +	if (seg_ptr->buf && fdt_magic(seg_ptr->buf) == FDT_MAGIC)
> +		return 1;
> +
>   	return 0;
>   }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
