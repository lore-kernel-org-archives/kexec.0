Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgjYJ-0007fH-UC
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 23:08:52 +0000
Message-ID: <52840666.5070800@zytor.com>
Date: Wed, 13 Nov 2013 15:08:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com>
 <20131113210432.GE7613@redhat.com> <5283EBCD.6070305@zytor.com>
 <20131113224104.GF7613@redhat.com> <528400DD.3040003@zytor.com>
 <20131113230056.GA19663@redhat.com>
In-Reply-To: <20131113230056.GA19663@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On 11/13/2013 03:00 PM, Vivek Goyal wrote:
> I think it should be easy to truncate ELF headers in kexec-tools too when
> we are preparing elf headers. I am not sure if it is right thing to do or
> not. If some entry is showing up in /proc/iomem as RAM, then kexec-tools
> need to believe that it is a possibility that kernel is using that pfn and
> that pfn needs to be dumped out in vmcore. IMHO, kernel should fix this
> issue.

The kernel will never use a fractional page, so that is not an issue.

> Secondly, I am writing in-kernel kexec support too and I prepare ELF
> headers there too. And I am facing the same problem there too. So if
> we truncate partial pages in e820 both kexec-tools and in kernel kexec
> implementation don't have to do anything.

I'm mostly worried about truncation upon truncation causing problems.
As long as the trimming is done once and with proper consideration for
abutting regions, I guess I'm okay with it, although it feels wrong to me.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
