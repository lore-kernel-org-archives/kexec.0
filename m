Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0NC-0007Yx-Bf
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:51:18 +0000
Date: Thu, 24 Sep 2015 14:50:54 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] Load crash kernel high on x86
Message-ID: <20150924065054.GD6217@dhcp-128-28.nay.redhat.com>
References: <20150923065655.3ecd3c1b@hananiah.suse.cz>
 <20150924032942.GC6217@dhcp-128-28.nay.redhat.com>
 <20150924084158.5a11c942@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150924084158.5a11c942@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 09/24/15 at 08:41am, Petr Tesarik wrote:
> On Thu, 24 Sep 2015 11:29:42 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 

> > How about get_crash_kernel_load_range? In kernel crashk_res and
> > crashk_low_res are all named as "Crash kernel", but only crashk_res is
> > used to load kernel/initrd stuffs.
> 
> I'm glad this patch is getting a bikeshedding kind of discussion. ;-)
> I don't mind calling the function whatever you like. So let's make it get_crash_kernel_load_range. Wait for v3. ;-)

Hi Petr,

I think it's a reasonable fix when I saw your v1 and offer my ack. Then
people think the function name should be adjusted. If you think like
that, I will take back my last comment, then you don't need to bother
to fix it.

Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
