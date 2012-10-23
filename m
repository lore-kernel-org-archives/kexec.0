Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQhyn-0000J7-Dn
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 17:09:26 +0000
Date: Tue, 23 Oct 2012 18:09:13 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121023170913.GA796@srcf.ucam.org>
References: <874nlrv2ni.fsf@xmission.com> <20121019020630.GA27052@redhat.com>
 <877gqnnnf0.fsf@xmission.com> <20121019143112.GB27052@redhat.com>
 <871ugqb4gj.fsf@xmission.com> <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com>
 <20121023163125.GC32085@srcf.ucam.org>
 <874nllunme.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874nllunme.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Tue, Oct 23, 2012 at 10:03:37AM -0700, Eric W. Biederman wrote:
> Matthew Garrett <mjg@redhat.com> writes:
> 
> > On Tue, Oct 23, 2012 at 09:19:27AM -0700, Eric W. Biederman wrote:
> >> No.  UEFI secure boot has absolutely nothing todo with this.
> >> 
> >> UEFI secure boot is about not being able to hijack the code EFI runs
> >> directly.  Full stop.
> >
> > No. It's about ensuring that no untrusted code can be run before any OS 
> > kernel, which means that no untrusted code can run *in* any OS kernel.
> 
> Hogwash.

Well, I don't think this conversation's going to go any further in a 
productive manner.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
