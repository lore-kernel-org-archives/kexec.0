Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URkim-0004nL-5w
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 14:49:28 +0000
In-Reply-To: <516B9714.80007@sr71.net>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
 <5166D18A.7090800@zytor.com> <20130412143104.GA4301@redhat.com>
 <5168208B.7050107@zytor.com> <51688803.8020401@sr71.net>
 <516B87A6.9080708@jp.fujitsu.com> <516B9714.80007@sr71.net>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 15 Apr 2013 07:49:13 -0700
Message-ID: <0ad804f8-7ed2-4952-bd96-b169beece359@email.android.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Hansen <dave@sr71.net>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Yinghai Lu <yinghai@kernel.org>, Cliff Wickman <cpw@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

This is also true on some x86 systems.

Dave Hansen <dave@sr71.net> wrote:

>On 04/14/2013 09:52 PM, HATAYAMA Daisuke wrote:
>> This sounds like there's no such issue on x86 cache mechanism. Is it
>> correct? If so, what is the difference between ia64 and x86 cache
>> mechanisms?
>
>I'm just going by the code comments:
>
>drivers/char/mem.c
>>                 /*
>>                  * On ia64 if a page has been mapped somewhere as
>uncached, then
>>                  * it must also be accessed uncached by the kernel or
>data
>>                  * corruption may occur.
>>                  */

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
