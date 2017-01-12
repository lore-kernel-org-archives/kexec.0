Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cRVyU-000836-4i
 for kexec@lists.infradead.org; Thu, 12 Jan 2017 03:22:52 +0000
Subject: Re: [PATCH] Add +~800M crashkernel explaination
References: <20161210002202.19829-1-robert@leblancnet.us>
 <20161210024927.GD1034@x1>
 <CAANLjFq92OLqsPmoz0FMHw9ZEyAm60s3M1UgkqTLtHabuQL6DA@mail.gmail.com>
 <5850B791.4040209@redhat.com>
 <CAANLjFokKcoDZR2YW2NR4ymRwwkJYLa66xWQUWsVoAg515jg=Q@mail.gmail.com>
 <5851D2F6.4020009@redhat.com>
 <CAANLjFpbk=jNi4xxqo+YGWwGic3OAAWbcmb_rCTNZ7VsZML2SQ@mail.gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <5876F6E1.4050001@redhat.com>
Date: Thu, 12 Jan 2017 11:24:17 +0800
MIME-Version: 1.0
In-Reply-To: <CAANLjFpbk=jNi4xxqo+YGWwGic3OAAWbcmb_rCTNZ7VsZML2SQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Robert LeBlanc <robert@leblancnet.us>, xlpang@redhat.com
Cc: kexec@lists.infradead.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org

On 01/12/2017 at 03:35 AM, Robert LeBlanc wrote:
> On Wed, Dec 14, 2016 at 4:17 PM, Xunlei Pang <xpang@redhat.com> wrote:
>> As I replied in another post, if you really want to detail the behaviour, should mention
>> "crashkernel=size[KMG][@offset[KMG]]" with @offset[KMG] specified explicitly, after
>> all, it's handled differently with no upper bound limitation, but doing this may put
>> the first kernel at the risk of lacking low memory(some devices require 32bit DMA),
>> must use it with care because the kernel will assume users are aware of what they
>> are doing and make a successful reservation as long as the given range is available.
> crashkernel=1024M@0x10000000
>
> I can't get the offset to work. It seems that it allocates the space
> and loads the crash kernel, but I couldn't get it to actually boot
> into the crash kernel. Does it work for you? I'm using the 4.9 kernel.

Not sure what is the problem you met, but kdump kernel boots well using 4.9 on my x86_64 machine.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
