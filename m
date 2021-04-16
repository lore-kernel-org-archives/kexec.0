Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMeD-009JjP-En
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 11:28:31 +0000
Message-ID: <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
Subject: Re: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
From: Mike Galbraith <efault@gmx.de>
Date: Fri, 16 Apr 2021 13:28:19 +0200
In-Reply-To: <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org

On Fri, 2021-04-16 at 19:07 +0800, Dave Young wrote:
>
> > We're excluding two ranges, allocate the scratch space we need to do that.
>
> I think 1 range should be fine, have you tested 1?

Have now, and vzalloc(struct_size(cmem, ranges, 1)) worked just fine.

	-Mike


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
