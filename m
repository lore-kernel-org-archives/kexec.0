Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bc6pT-0002uF-St
 for kexec@lists.infradead.org; Tue, 23 Aug 2016 08:13:04 +0000
Received: by mail-yw0-f175.google.com with SMTP id r9so67951704ywg.0
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 01:12:43 -0700 (PDT)
Date: Tue, 23 Aug 2016 13:42:38 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 0/7] (kexec-tools) arm64: add kdump support
Message-ID: <20160823081238.GB13501@localhost.localdomain>
References: <20160809020032.28654-1-takahiro.akashi@linaro.org>
 <20160810175648.GB24137@localhost.localdomain>
 <20160819071930.GG20080@linaro.org>
 <20160819101423.GA22221@localhost.localdomain>
 <20160822081016.GK20080@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160822081016.GK20080@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, horms@verge.net.au, geoff@infradead.org, kexec@lists.infradead.org

On 22/08/2016:05:10:17 PM, AKASHI Takahiro wrote:
> On Fri, Aug 19, 2016 at 03:44:23PM +0530, Pratyush Anand wrote:
> > page_offset is the virtual address of phys_offset, right?
> > 
> > ehdr.e_entry is the virtual address of "kernel Code Start PA", right?
> > 
> > If yes, then why should n't above be correct for all linear regions.
> 
> What I was thinking of is that we'd better fake arm64_mem.text_offset
> instead of calculating a page_offset because text_offset is also used
> in arm64_load_other_segments(). Here, if the first segment doesn't not
> contain kernel text, image_base will be incorrect.

IMHO, we should keep all definitions in kexec-tools as close as possible to that
of corresponding definitions in kernel. This will help us to avoid any confusion
in future.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
