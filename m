Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo1d5-000897-43
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 01:51:56 +0000
Date: Wed, 4 Dec 2013 09:51:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 6/6] kexec: Support for Kexec on panic using new system
 call
Message-ID: <20131204015127.GC3298@localhost.localdomain>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-7-git-send-email-vgoyal@redhat.com>
 <20131128112816.GC4318@dhcp-16-252.nay.redhat.com>
 <20131202153037.GD18642@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131202153037.GD18642@redhat.com>
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
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On 12/02/13 at 10:30am, Vivek Goyal wrote:
> On Thu, Nov 28, 2013 at 07:28:16PM +0800, Baoquan He wrote:
> 
> [..]
> > > +int crash_copy_backup_region(struct kimage *image)
> > > +{
> > 
> > Why need this func be called, backup region has been added into crash
> > segment by kexec_add_buffer, and then buffer copy is done in
> > kimage_load_crash_segment. I think this copy is handled twice. Please
> > correct me if I am wrong.
> > 
> 
> Hi Bao,
> 
> kexec_add_buffer() will copy the backup region but it will happen when
> crash kernel is loaded. We want snapshot of backup region at the time
> of crash and that's why this second call to copy backup region and it
> is executed after the crash.

Did we do this before? And will this region  be changed after 1st kernel
boot


> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
