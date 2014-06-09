Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wu1XX-0006Ei-Nr
 for kexec@lists.infradead.org; Mon, 09 Jun 2014 15:31:17 +0000
Date: Mon, 9 Jun 2014 11:30:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140609153033.GC22049@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-8-git-send-email-vgoyal@redhat.com>
 <20140606065605.GE2785@dhcp-17-89.nay.redhat.com>
 <20140606181859.GK1526@redhat.com>
 <20140609021122.GB1924@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140609021122.GB1924@darkstar.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, WANG Chao <chaowang@redhat.com>

On Mon, Jun 09, 2014 at 10:11:22AM +0800, Dave Young wrote:

[..]
> > > > +	image->cmdline_buf = vzalloc(cmdline_len);
> > > 
> > > You should validate the upper/lower boundary of cmdline_len before
> > > calling vzalloc. When cmdline_len is 0 or too large, vmalloc failure
> > > message would be fired.
> > 
> > What's the upper length of vzalloc(). I think if it is too big to alloc,
> > then vzalloc() should return me an error?
> 
> function __vmalloc_node_range:
>         if (!size || (size >> PAGE_SHIFT) > totalram_pages)
>                 goto fail;
> 
> So I think only checking cmdline_len == 0 is enough.
> 
> For the upper length shouldn't it be stripped to COMMAND_LINE_SIZE?

We might be booting a newer kernel supporting bigger command line size
as compared to running kernel. So we query bzImage header to figure out
what's the maximum command line length supported.

Just that currently that check happens later during image load time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
