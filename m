Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoG7C-00032R-SR
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 17:19:59 +0000
Date: Wed, 4 Dec 2013 12:19:34 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/6] kexec: Support for Kexec on panic using new system
 call
Message-ID: <20131204171934.GB19087@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-7-git-send-email-vgoyal@redhat.com>
 <20131204014105.GB3298@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131204014105.GB3298@localhost.localdomain>
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
To: Baoquan He <bhe@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Wed, Dec 04, 2013 at 09:41:05AM +0800, Baoquan He wrote:
> On 11/20/13 at 12:50pm, Vivek Goyal wrote:
> > This patch adds support for loading a kexec on panic (kdump) kernel usning
> > new system call.
> > +int load_crashdump_segments(struct kimage *image)
> > +{
> > +	unsigned long src_start, src_sz;
> > +	unsigned long elf_addr, elf_sz;
> > +	int ret;
> > +
> > +	/*
> > +	 * Determine and load a segment for backup area. First 640K RAM
> > +	 * region is backup source
> > +	 */
> > +
> > +	ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> > +				image, determine_backup_region);
> > +
> > +	/* Zero of postive return values are ok */
>                 ^
> Here I guess it is "or".

Yep. Will fix it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
