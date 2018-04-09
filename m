Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f65.google.com ([209.85.214.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5SKR-0007Qc-Bn
 for kexec@lists.infradead.org; Mon, 09 Apr 2018 08:39:09 +0000
Received: by mail-it0-f65.google.com with SMTP id 142-v6so9903598itl.5
 for <kexec@lists.infradead.org>; Mon, 09 Apr 2018 01:38:57 -0700 (PDT)
Subject: Re: [PATCH v6 3/5] kexec: Do not special-case the -s option
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
 <1ce7ef9717b1e1a721a1012d1de1ed2b4eae9485.1522242915.git.msuchanek@suse.de>
 <20180405130558.30486489@ezekiel.suse.cz>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <8eecd9e4-d98e-af28-6afd-a9526e609b8b@redhat.com>
Date: Mon, 9 Apr 2018 14:08:47 +0530
MIME-Version: 1.0
In-Reply-To: <20180405130558.30486489@ezekiel.suse.cz>
Content-Language: en-US
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
To: Petr Tesarik <ptesarik@suse.cz>, Michal Suchanek <msuchanek@suse.de>
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

On 04/05/2018 04:35 PM, Petr Tesarik wrote:
> On Wed, 28 Mar 2018 15:15:16 +0200
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
>> It is parsed separately to save a few CPU cycles when setting up other
>> options but it just complicates the code. So fold it back and set up all
>> flags for both KEXEC_LOAD and KEXEC_FILE_LOAD
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>>   kexec/kexec.c | 25 ++++---------------------
>>   1 file changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index b793f31ea501..68ae0594d4a7 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> [...]
>> @@ -1354,11 +1340,8 @@ int main(int argc, char *argv[])
>>   			do_exec = 0;
>>   			do_shutdown = 0;
>>   			do_sync = 0;
>> -			if (do_kexec_file_syscall)
>> -				kexec_file_flags |= KEXEC_FILE_ON_CRASH;
>> -			else
>> -				kexec_flags = KEXEC_ON_CRASH;
>> -			break;
> 
> Argh. This break was rather important. "kexec -p" now segfaults on
> me, as it falls through to parsing non-existent optarg. :-(
> 

Sigh. Seems 'kexec -p' was never tested with properly with this 
patchset. This is one of the problems I see with this patchset, so we 
definitely would like to get rid of this segmentation fault.

Petr, I am going to share my Tested-by for the patch you shared for 
fixing this issue in the separate thread.

I would request the fix to be picked up earlier into kexec-tools as 
'kexec -p' is currently broken in upstream kexec-tools.

Regards,
Bhupesh


> 
>> +			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
>> +			kexec_flags = KEXEC_ON_CRASH;
>>   		case OPT_MEM_MIN:
>>   			mem_min = strtoul(optarg, &endptr, 0);
>>   			if (*endptr) {
>> @@ -1383,7 +1366,7 @@ int main(int argc, char *argv[])
>>   			do_reuse_initrd = 1;
>>   			break;
>>   		case OPT_KEXEC_FILE_SYSCALL:
>> -			/* We already parsed it. Nothing to do. */
>> +			do_kexec_file_syscall = 1;
>>   			break;
>>   		case OPT_STATUS:
>>   			do_status = 1;
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
