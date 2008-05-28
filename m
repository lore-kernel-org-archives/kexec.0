Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K1LEQ-0004hc-Rp
	for kexec@lists.infradead.org; Wed, 28 May 2008 12:58:19 +0000
Date: Wed, 28 May 2008 08:57:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/2] kexec jump -v10: save/restore device state
Message-ID: <20080528125742.GA3884@redhat.com>
References: <1211449099.12819.15.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1211449099.12819.15.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, May 22, 2008 at 05:38:19PM +0800, Huang, Ying wrote:

[..]
> Known issues:
> 
> - Can not work with the new devices hibernation operations in
>   2.6.26-rc2-mm1 so far. Working on this now.
> 
> - APIC is not put into legacy mode during kexec, so kexec may failed
>   (no IRQ) if APIC is not put into legacy mode.
> 
> - The suspend/resume callback of device drivers are used to put
>   devices into quiescent state. This will unnecessarily (possibly
>   harmfully) put devices into low power state. This is intended to be
>   solved by separating device quiesce/unquiesce callback from the
>   device suspend/resume callback.
> 
> - Because the segment number supported by sys_kexec_load is limited,
>   hibernation image with many segments may not be load. This is
>   planned to be eliminated by adding a new flag to sys_kexec_load to
>   make a image can be loaded with multiple sys_kexec_load invoking.
> 
> 

These two patches look good to me. I think once you have worked out
issues with IOAPIC and generated patches for compatibility with
new suspend/resume callbacks, these patches are good enough to get
some testing going on in -mm tree.

I will also test out -v10 very soon.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
