Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vfh93-0002xj-8C
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 02:22:30 +0000
Message-ID: <52803F15.3080204@zytor.com>
Date: Sun, 10 Nov 2013 18:21:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 0/7 v2] kexec kernel efi runtime support
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131108143118.GA22636@console-pimps.org>
 <20131109035739.GB4294@dhcp-16-126.nay.redhat.com>
 <527DC1BE.6030107@zytor.com>
 <20131111021356.GC4407@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131111021356.GC4407@dhcp-16-126.nay.redhat.com>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, mjg59@srcf.ucam.org, Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, vgoyal@redhat.com

On 11/10/2013 06:13 PM, Dave Young wrote:
> 
> Huang Ying <ying.huang@intel.com> created the debugfs file for boot_params.
> His first version patch tried sysfs, but sysfs is not designed for such
> binary blobs so finally it go to debugfs.
> 

That is a misunderstanding.  Binary blobs can exist in sysfs as long as
the blob is something that is inherently a blob.  This is admittedly a
corner case, but it is without any doubt a protocol-defined binary
structure.

The reason it was put in debugfs is that there was no non-debug user for
it at the time.

> Any idea for this is welcome, till now I have no better idea for such kind
> of data. We should have another *fs instead of using debugfs.

The problem with debugfs is that things go into debugfs with largely no
auditing.  As a result, mounting debugfs is very likely to mean that
your system is exploitable one way or another.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
