Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muczm-009OQl-58
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 16:07:11 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7EqXqH018204
 for <kexec@lists.infradead.org>; Tue, 7 Dec 2021 16:07:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ct9ru1sae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 07 Dec 2021 16:07:04 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7EvRD8003830
 for <kexec@lists.infradead.org>; Tue, 7 Dec 2021 16:07:03 GMT
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390: add variable command line size
References: <20211122071401.3106858-1-svens@linux.ibm.com>
 <20211122071401.3106858-2-svens@linux.ibm.com>
 <20211207152940.2f6536e6@rhtmp>
Date: Tue, 07 Dec 2021 17:06:58 +0100
In-Reply-To: <20211207152940.2f6536e6@rhtmp> (Philipp Rudo's message of "Tue, 
 7 Dec 2021 15:29:40 +0100")
Message-ID: <yt9dwnkgpffh.fsf@linux.ibm.com>
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
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>, kexec@lists.infradead.org

Hi Philipp,

Philipp Rudo <prudo@redhat.com> writes:

>> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
>> index 3c24fdfe3c7c..7747d02399db 100644
>> --- a/kexec/arch/s390/kexec-image.c
>> +++ b/kexec/arch/s390/kexec-image.c
>> @@ -25,7 +25,7 @@
>>  #include <fcntl.h>
>>  
>>  static uint64_t crash_base, crash_end;
>> -static char command_line[COMMAND_LINESIZE];
>> +static char *command_line;
>
> isn't this the perfect opportunity to get rid of this global variable
> and...
>
>>  static void add_segment_check(struct kexec_info *info, const void *buf,
>>  			      size_t bufsz, unsigned long base, size_t memsz)
>> @@ -38,11 +38,16 @@ static void add_segment_check(struct kexec_info *info, const void *buf,
>>  
>>  int command_line_add(const char *str)
>
> ... simply pass the pointer as an argument ;)

The reason for it being global is that command_line_add() might get
called multiple times. But yes, we could move that variable scope into
the calling function.

Thanks
Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
