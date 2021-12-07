Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mud5J-009PQr-4c
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 16:12:54 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390: add support for --reuse-cmdline
References: <20211122071401.3106858-1-svens@linux.ibm.com>
 <20211122071401.3106858-4-svens@linux.ibm.com>
 <20211207153404.4ff7f7fd@rhtmp>
Date: Tue, 07 Dec 2021 17:12:42 +0100
In-Reply-To: <20211207153404.4ff7f7fd@rhtmp> (Philipp Rudo's message of "Tue, 
 7 Dec 2021 15:34:04 +0100")
Message-ID: <yt9dsfv4pf5x.fsf@linux.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Philipp Rudo <prudo@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Alexander Egorenkov <egorenar@linux.ibm.com>

Hi Philipp,

Philipp Rudo <prudo@redhat.com> writes:

>> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
>> index dbeb689b830a..310d967ea331 100644
>> --- a/kexec/arch/s390/kexec-image.c
>> +++ b/kexec/arch/s390/kexec-image.c
>> @@ -72,6 +72,10 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
>>  		case OPT_RAMDISK:
>>  			ramdisk = optarg;
>>  			break;
>> +		case OPT_REUSE_CMDLINE:
>> +			free(command_line);
>> +			command_line = get_command_line();
>
> get_command_line reads a maximum of 2048 bytes from /prc/cmdline. With
> the configurable size on s390 defaulting to 4096 bytes this will
> ultimately cause problems. So you need to make get_command_line more
> flexible first.

Thanks for pointing this out, i wasn't aware of that limitation. So we
likely want to change that to some dynamic allocation.

Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
