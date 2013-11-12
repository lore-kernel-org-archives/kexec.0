Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg4Xe-0001TJ-Dv
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 03:21:27 +0000
Message-ID: <52819E71.70201@zytor.com>
Date: Mon, 11 Nov 2013 19:20:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 1/3 v2] Add function get_bootparam
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>	
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
In-Reply-To: <1384219658.1847.84.camel@misato.fc.hp.com>
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
To: Toshi Kani <toshi.kani@hp.com>, dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On 11/11/2013 05:27 PM, Toshi Kani wrote:
> On Tue, 2013-11-05 at 16:29 +0800, dyoung@redhat.com wrote:
>> Not only setup_subarch will get data from debugfs file
>> boot_params/data, later code for adding efi_info will
>> also need do same thing. Thus add a common function here
>> for later use.
> 
> get_bootparam() calls find_mnt_by_fsname("debugfs"), which assumes that
> debugfs is mounted with device name "debugfs".  This function fails
> when:
>  - debugfs is not mounted, or
>  - debugfs is mounted with a different device name, such as nodev [1].
> 
> This issue is not introduced by this patch.  But the original code,
> which sets hardware_subarch, seems to work even if it failed to access
> debugfs (which is ignored) since hardware_subarch is zero most of the
> cases anyway.  With this change, however, this failure now makes the 2nd
> kernel unbootable.  So, it needs to be addressed to make this code path
> work reliably (or kexec should fail at least).
> 

Greg, Ingo,

Since there is now a legitimate user of this stuff, can we actually
export this in sysfs (or something else other than sploit^Wdebugfs)?

kexec-tools can have a fallback to debugfs if we really need it, but
making people mount debugfs to have some essential piece of
functionality scares the heck out of me.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
