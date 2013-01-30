Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x22c.google.com ([2607:f8b0:4001:c03::22c])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0bez-0003Uk-Tl
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 17:41:22 +0000
Received: by mail-ie0-f172.google.com with SMTP id c10so1542814ieb.3
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 09:41:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51094FD5.2070909@zytor.com>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
Date: Wed, 30 Jan 2013 09:41:14 -0800
Message-ID: <CAE9FiQWSXc+Xi1y7iXDD97217Yp1pgOPtRCtE2cGBYfRNCzH9w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
From: Yinghai Lu <yinghai@kernel.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Wed, Jan 30, 2013 at 8:52 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> The e820 map is fundamentally what you care about, and it has to be passed
> correctly anyway -- or your changes are utterly broken.  The modifications
> that have to be performed (from RAM to KDUMP) is trivial.
>
> I have to admit to being rather confused as to the separation of various
> bits of kdump between the host kernel and various user-space components, but
> the whole use of the command line to pass the memory map seems just broken
> in light of everything that can go wrong.

Thomas,

Can you try to work out patch for  kexec-tools that kdump change all
ram to KDUMP_RESERVED,
and only make crask_kernel  in /proc/iomem to be RAM type?

then we only kernel patch for kdump will check KDUMP_REDREVED and RAM
type to get saved_max_pfn.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
