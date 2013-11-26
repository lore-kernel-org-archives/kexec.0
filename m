Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlBsn-00016S-8e
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 06:12:26 +0000
Date: Tue, 26 Nov 2013 14:11:24 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 0/4 v3] kexec-tools: efi runtime support
Message-ID: <20131126061124.GB9727@dhcp-16-126.nay.redhat.com>
References: <20131121064043.969000753@dhcp-16-126.nay.redhat.com>
 <1385159448.1791.161.camel@misato.fc.hp.com>
 <20131124031228.GA1754@dhcp-16-126.nay.redhat.com>
 <1385393451.1791.168.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385393451.1791.168.camel@misato.fc.hp.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

Hi, Toshi
On 11/25/13 at 08:30am, Toshi Kani wrote:
> HI Dave,
> 
> I will test v4 again.  This time, I will test "memmap=exactmap" option
> as well.  I have tested the following cases before.  Are there any other
> cases you'd like me to test?
> 
>  - kdump
>  - multiple fast reboots and then kdump
>  - old kexec and new kernel w/ noefi & acpi_rsdp option
>  - new kexec and old kernel w/ noefi & acpi_rsdp option

There's one more test case is w/ debugfs mounted in 1st kernel due to the
new version exports setup_data to sysfs.

For the exactmap I think it's a corner case, I just tested it in virtual
machine I think setup a right cmdline is hard. But feel free to test it if
you can.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
