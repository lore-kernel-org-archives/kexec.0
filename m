Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQhiH-0004lj-18
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 16:52:22 +0000
Date: Tue, 23 Oct 2012 17:52:02 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] Kdump with signed images
Message-ID: <20121023165201.GA32748@srcf.ucam.org>
References: <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <20121023154123.GA30730@srcf.ucam.org>
 <87d309xhmc.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d309xhmc.fsf_-_@xmission.com>
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

On Tue, Oct 23, 2012 at 09:44:59AM -0700, Eric W. Biederman wrote:

> Hogwash.  The kernel verifing a signature of /sbin/kexec at exec time is
> perfectly reasonable, and realistic.  In fact finding a way to trust
> small bits of userspace even if root is compromised seems a far superior
> model to simply solving the signing problem for /sbin/kexec.

The kernel verifying the signature of /sbin/kexec and then knowing that 
it should only grant permission to make this syscall to /sbin/kexec, 
without that policy being provided by userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
