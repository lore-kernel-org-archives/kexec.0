Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQgbx-00039s-MZ
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 15:41:47 +0000
Date: Tue, 23 Oct 2012 16:41:24 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121023154123.GA30730@srcf.ucam.org>
References: <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121023145920.GD16496@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Tue, Oct 23, 2012 at 10:59:20AM -0400, Vivek Goyal wrote:

> But what about creation of a new program which can call kexec_load()
> and execute an unsigned kernel. Doesn't look like that will be
> prevented using IMA.

Right. Trusting userspace would require a new system call that passes in 
a signature of the userspace binary, and the kernel would then have to 
verify the ELF object in memory in order to ensure that it 
matches the signature. Verifying that the copy on the filesystem is 
unmodified isn't adequate - an attacker could simply have paused the 
process and injected code. Realistically, the only solution here is for 
the kernel to verify that the kernel it's about to boot is signed and 
for it not to take any untrusted executable code from userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
