Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIe6C-0002eR-Dx
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 15:41:53 +0000
Date: Thu, 30 Jun 2016 11:41:19 -0400
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160630154119.GB3058@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1495163.EskJqap5EJ@hactar>
 <20160629194518.GA5488@dhcp-128-65.nay.redhat.com>
 <1736656.LVyt5NrzWE@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1736656.LVyt5NrzWE@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, Eric Biederman <ebiederm@xmission.com>

On 06/29/16 at 06:09pm, Thiago Jung Bauermann wrote:
> Am Mittwoch, 29 Juni 2016, 15:45:18 schrieb Dave Young:
> > On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > > Am Dienstag, 28 Juni 2016, 15:20:55 schrieb Dave Young:
> > > > On 06/27/16 at 04:21pm, Dave Young wrote:
> > > > Using one argument for both sounds more reasonable than using a
> > > > separate
> > > > argument for memory walk..
> > > 
> > > I agree. This patch doesn't use a separate top_down argument, it's the
> > > same patch I sent earlier except that the comments to struct kexec_buf
> > > are in patch 2/9. What do you think?
> > 
> > It looks good except one nitpick inline..
> > 
> >
> > > +/**
> > > + * kexec_locate_mem_hole - find free memory to load segment or use in
> > > purgatory
>  
> > It is not necessary to use only for purgatory load..
> 
> Ok, what about this?
> 
> /**
>  * kexec_locate_mem_hole - find free memory in a given kimage.

Hmm, a given kimage sounds not correct, I can not get a better way to
describe it. How about below with a little change to your previous one:

kexec_locate_mem_hole - find a free chunk of memory to load kexec segment.
In powerpc the memory chunk can also be used for the purgatory stack.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
