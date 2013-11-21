Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZaR-0004MD-D8
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:06:48 +0000
Date: Thu, 21 Nov 2013 19:06:20 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131121190620.GA25951@srcf.ucam.org>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121190350.GC17070@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, ebiederm@xmission.com

On Thu, Nov 21, 2013 at 11:03:50AM -0800, Greg KH wrote:

> This could be done as we do with modules, and just tack the signature
> onto the end of the 'blob' of the image.  That way we could use the same
> tool to sign the binary as we do for modules, and save the need for
> extra parameters in the syscall.

That would require a certain degree of massaging from userspace if we 
want to be able to use the existing Authenticode signatures. Otherwise 
we need to sign kernels twice.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
