Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcdn-iport-5.cisco.com ([173.37.86.76])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQKDW-00071p-Fd
 for kexec@lists.infradead.org; Thu, 21 Jul 2016 20:05:11 +0000
Subject: Re: IO memory read from /proc/vmcore leads to hang.
References: <57841399.1030703@cisco.com> <578FCE9A.50305@cisco.com>
 <CAJGZr0KwbB+2Qdv4AAp1qVr60PQPGiJqQum5awSFrptATmHYUA@mail.gmail.com>
 <5790E80F.7080109@cisco.com>
 <CAJGZr0LrWsQzM-UYS6chQsRYeLNzgyENpzaNxQGHjWfJ+w232g@mail.gmail.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <57912ADF.8070803@cisco.com>
Date: Thu, 21 Jul 2016 13:04:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAJGZr0LrWsQzM-UYS6chQsRYeLNzgyENpzaNxQGHjWfJ+w232g@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 07/21/2016 12:33 PM, Maxim Uvarov wrote:
> 2016-07-21 18:19 GMT+03:00 Daniel Walker <danielwa@cisco.com>:
>>   There appears to be no code which checks what is or is not System ram,
>> there is nothing that checks the device tree to see what is IO memory, and
>> nothing reads /proc/iomem .. So AFAIK nothing cares if it's IO memory, or
>> system ram, and there's no method to config things to skip any memory in the
>> system, except in makedumpfile which can skip symbols not IO memory.
>>
>>
> Daniel,  unfortunately it's long time for me when I looked to powerpc
> code. But I just
> checked that here:
>
> kexec-tools-2.0.6/kexec/arch/ppc64/kexec-ppc64.c
>
> is probably what you need.

I have a powerpc32 .. In the powerpc64 file I only see something called 
"reserved-ranges" which may do what I want, however, that doesn't exist 
in the 32bit version.  It appers the reserved-ranges is used by OPAL 
firmware , which I don't have. There doesn't appear to be anything 
generic in ppc64 to exclude device IO memory.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
