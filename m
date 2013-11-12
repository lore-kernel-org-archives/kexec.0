Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgAQV-0000QH-Ew
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 09:38:28 +0000
Message-ID: <5281F6D5.4090700@zytor.com>
Date: Tue, 12 Nov 2013 01:37:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 1/3 v2] Add function get_bootparam
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com> <52819E71.70201@zytor.com>
 <20131112075831.GA6213@kroah.com>
 <20131112080854.GD6999@dhcp-16-126.nay.redhat.com>
 <20131112083012.GB7708@kroah.com>
In-Reply-To: <20131112083012.GB7708@kroah.com>
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
To: Greg KH <greg@kroah.com>, Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On 11/12/2013 12:30 AM, Greg KH wrote:
> 
> And these binary data blobs are a "standard" somewhere, and will not
> change per kernel version change?
> 
> If so, that structure is fine with me.
> 

Correct.  The structure is documented in Documentation/x86/boot.txt, and
has been largely invariant (but extended) since the beginning of Linux.
 It has sometimes taken some serious work to keep it that way.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
