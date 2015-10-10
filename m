Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZktCk-0006H9-VD
 for kexec@lists.infradead.org; Sat, 10 Oct 2015 12:24:51 +0000
Date: Sat, 10 Oct 2015 20:24:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 06/10] iommu/amd: Add functions
 copy_command_buffer/copy_event_buffer
Message-ID: <20151010122424.GA31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
 <1443076656-31776-7-git-send-email-bhe@redhat.com>
 <20150929160439.GN3036@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150929160439.GN3036@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Joerg,

On 09/29/15 at 06:04pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:32PM +0800, Baoquan He wrote:
> > Copy command buffer and event buffer from the old to kdump kernel.
> > 
> > Still there are 2 problems:
> >   1) Not very sure if this is necessary. If do not copy the old command buffer, and
> > only set the newly allocated command buffer, is there anything wrong?
> 
> No, there is no need to copy command and event buffers. Just make sure
> they get re-initialized and flush all iommu caches after setting the new
> device table.

Thanks for your reviewing.

I did a lot of tests. Seems that it doesn't matter with copy or without
a copy. And it's also OK even completely ignore the command buffer and
event log handling here.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
