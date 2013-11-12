Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg3WC-00086k-RQ
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 02:15:53 +0000
Date: Tue, 12 Nov 2013 10:14:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131112021439.GB4341@dhcp-16-126.nay.redhat.com>
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Toshi Kani <toshi.kani@hp.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/11/13 at 06:27pm, Toshi Kani wrote:
> On Tue, 2013-11-05 at 16:29 +0800, dyoung@redhat.com wrote:
> > Not only setup_subarch will get data from debugfs file
> > boot_params/data, later code for adding efi_info will
> > also need do same thing. Thus add a common function here
> > for later use.
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

Toshi, Thanks for your suggestion, it make sense. Will fix it.

> 
> [1]
> https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_MRG/2/html/Realtime_Tuning_Guide/sect-Realtime_Tuning_Guide-Realtime_Specific_Tuning-Mount_debugfs.html
> 
> Thanks,
> Toshi
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
