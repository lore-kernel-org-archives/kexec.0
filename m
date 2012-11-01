Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTs4z-0007oM-69
 for kexec@lists.infradead.org; Thu, 01 Nov 2012 10:32:54 +0000
Message-ID: <50924FCD.2020100@hitachi.com>
Date: Thu, 01 Nov 2012 19:32:45 +0900
From: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
MIME-Version: 1.0
Subject: Re: [Patch 0/2] Exclude hwpoison page from vmcore dump
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
 <50912CFB.5000508@hitachi.com> <20121031141426.GE1865@redhat.com>
In-Reply-To: <20121031141426.GE1865@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Vivek,

(2012/10/31 23:14), Vivek Goyal wrote:
> If hwpoision functionality is not available in hardware, then respective
> bit will not be even set in struct page and it will be saved by default.
> So it should not matter whether hardware has hwpoision functionality
> or not.

Thanks, I understand.

> I think that removing hwpoisno pages by default makes sense. If somebody
> does have a reasonable case of not doing so, then we could either
> introduce anther filtering level (based on type) or add another command
> line option like (--no-hwposion-filtering) etc.

I agree with you.
If somebody requests to support for disabling the filter of hwpoison pages,
this option will be discussed.

Regards,
Mitshuhiro Tanino (mitsuhiro.tanino.gm@hitachi.com)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
