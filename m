Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VakEj-0001Ki-Ap
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 10:39:54 +0000
Date: Mon, 28 Oct 2013 10:39:29 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131028103929.GA4407@srcf.ucam.org>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
 <20131028094223.GA2335@srcf.ucam.org>
 <20131028095459.GE25527@dhcp-16-126.nay.redhat.com>
 <20131028101256.GA3226@srcf.ucam.org>
 <20131028103412.GG25527@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028103412.GG25527@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On Mon, Oct 28, 2013 at 06:34:12PM +0800, Dave Young wrote:
> On 10/28/13 at 10:12am, Matthew Garrett wrote:
> > Right, but previously acpi_rsdp was passed automatically and now it 
> > won't be?
> 
> Yes, it was. I'm removing them in kexec-tools patches for efi runtime support.

If I upgrade kexec-tools and try to launch an old kernel, I now need to 
add an extra parameter?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
