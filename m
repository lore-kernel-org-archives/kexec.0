Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V3vFU-0000KO-Dz
 for kexec@lists.infradead.org; Mon, 29 Jul 2013 21:45:00 +0000
Date: Mon, 29 Jul 2013 14:44:19 -0700
From: Matt Wilson <msw@amazon.com>
Subject: Re: [PATCH] kexec/kdump implementation for Xen PV domU
Message-ID: <20130729214419.GA4239@u109add4315675089e695.ant.amazon.com>
References: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
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
To: Daniel Kiper <dkiper@net-space.pl>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, gregkh@linuxfoundation.org, daniel.kiper@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, abyde@acunu.com, tim@acunu.com, ebiederm@xmission.com, brandon@ifup.org, grzegorz.milos@gmail.com, virtualization@lists.linux-foundation.org

On Mon, Jul 29, 2013 at 07:15:43PM +0200, Daniel Kiper wrote:
> Hi all,
> 
> Here I am sending as attachments patches enabling kexec/kdump
> support in Xen PV domU. Only x84_64 architecture is supported.
> There is no support for i386 but some code could be easily reused.
> Here is a description of patches:

[...]

>   - kexec-kernel-only_20121203.patch: this patch fixes timer
>     issue on Amazon EC2 machines.

Hi Daniel,

Do you know the cause of this issue? Does it have something to do with
singleshot timer migration when offlining/onlining SMP CPUs?

--msw

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
