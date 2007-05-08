Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlR8A-0005LM-NB
	for kexec@lists.infradead.org; Tue, 08 May 2007 10:57:37 -0400
In-Reply-To: <20070508061454.GF8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE38.5090901@am.sony.com> <20070508061454.GF8170@verge.net.au>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <e9a549b7a8225faa255906285ac8e151@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Spam:****, Re: [patch 5/5] kexec fix ppc64 device-tree mem node
Date: Tue, 8 May 2007 09:57:13 -0500
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>


On May 8, 2007, at 1:14 AM, Simon Horman wrote:

> X-SpamDetect-Info: ------------- Start ASpam results ---------------
> X-SpamDetect-Info: This message may be spam. This message BODY has 
> been altered to show you the spam information
> X-SpamDetect: ****: 4.500000 From3consonants=0.5, GreyPassed=1.0, 
> DodgySource=2.0, SPF Default Fail=1.0
> X-SpamDetect-Info: ------------- End ASpam results -----------------
>
> On Mon, May 07, 2007 at 05:03:04PM -0700, Geoff Levand wrote:
>> Change the ppc64 device-tree memory node name spec to match the 
>> allowable names
>> specified in the booting-without-of document.
>>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>
> Again, this seems fine to me, but I'm not an expert on the device tree.
> Milton, how does this change sit with you?

[several cases of]
>> -		if (strncmp(dentry->d_name, "memory@", 7))
>> +		if (strncmp(dentry->d_name, "memory", 6))

Thinking about it a bit, this makes the check too generic.   There are
firmware platforms that generate /memory-controller nodes which should
not be found.   While we really should be looking for the device type,
for now the simplest would be to accept ether memory@ or memory\0.  The
one counting the nodes could remain memory, since we are just sizing an
allocation.


>
>> ---
>>  kexec/arch/ppc64/crashdump-ppc64.c |    2 +-
>>  kexec/arch/ppc64/kexec-ppc64.c     |   10 +++++-----
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> --- kexec-tools-hacked.orig/kexec/arch/ppc64/crashdump-ppc64.c
>> +++ kexec-tools-hacked/kexec/arch/ppc64/crashdump-ppc64.c
>> @@ -129,7 +129,7 @@ static int get_crash_memory_ranges(struc
>>  		goto err;
>>  	}
>>  	while ((dentry = readdir(dir)) != NULL) {
>> -		if (strncmp(dentry->d_name, "memory@", 7))
>> +		if (strncmp(dentry->d_name, "memory", 6))
>>  			continue;
>>  		strcpy(fname, device_tree);
>>  		strcat(fname, dentry->d_name);
>> --- kexec-tools-hacked.orig/kexec/arch/ppc64/kexec-ppc64.c
>> +++ kexec-tools-hacked/kexec/arch/ppc64/kexec-ppc64.c
>> @@ -98,7 +98,7 @@ err1:
>>  }
>>
>>  /*
>> - * Count the memory@ nodes under /proc/device-tree and populate the
>> + * Count the memory nodes under /proc/device-tree and populate the
>>   * max_memory_ranges variable. This variable replaces 
>> MAX_MEMORY_RANGES
>>   * macro used earlier.
>>   */
>> @@ -114,7 +114,7 @@ static int count_memory_ranges(void)
>>  	}
>>
>>  	while ((dentry = readdir(dir)) != NULL) {
>> -		if (strncmp(dentry->d_name, "memory@", 7) &&
>> +		if (strncmp(dentry->d_name, "memory", 6) &&
>>  		    strncmp(dentry->d_name, "pci@", 4))
>>  			continue;
>>  		max_memory_ranges++;
>> @@ -170,7 +170,7 @@ static int get_base_ranges(void)
>>  		return -1;
>>  	}
>>  	while ((dentry = readdir(dir)) != NULL) {
>> -		if (strncmp(dentry->d_name, "memory@", 7))
>> +		if (strncmp(dentry->d_name, "memory", 6))
>>  			continue;
>>  		strcpy(fname, device_tree);
>>  		strcat(fname, dentry->d_name);
>> @@ -272,7 +272,7 @@ static int get_devtree_details(unsigned
>>
>>  	while ((dentry = readdir(dir)) != NULL) {
>>  		if (strncmp(dentry->d_name, "chosen", 6) &&
>> -			strncmp(dentry->d_name, "memory@0", 8) &&
>> +			strncmp(dentry->d_name, "memory", 6) &&
>>  			strncmp(dentry->d_name, "pci@", 4) &&
>>  			strncmp(dentry->d_name, "rtas", 4))
>>  			continue;
>> @@ -452,7 +452,7 @@ static int get_devtree_details(unsigned
>>  				add_usable_mem_rgns(rtas_base, rtas_size);
>>  		} /* rtas */
>>
>> -		if (strncmp(dentry->d_name, "memory@0", 8) == 0) {
>> +		if (strncmp(dentry->d_name, "memory", 6) == 0) {
>>  			strcat(fname, "/reg");
>>  			if ((file = fopen(fname, "r")) == NULL) {
>>  				perror(fname);
>>
>> -- 
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
> -- 
> Horms
>   H: http://www.vergenet.net/~horms/
>   W: http://www.valinux.co.jp/en/
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
