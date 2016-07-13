Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNCHc-0005oB-2m
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 05:00:28 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D4xJ0Z134183
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 01:00:06 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24566wnta8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 01:00:05 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 23:00:05 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160712221804.GV1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
Date: Wed, 13 Jul 2016 14:59:51 +1000
MIME-Version: 1.0
Message-Id: <87twfunneg.fsf@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Petr Tesarik <ptesarik@suse.cz>
Cc: bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
>> I'm not an expert on DTB, so I can't provide an example of code
>> execution, but you have already mentioned the /chosen/linux,stdout-path
>> property. If an attacker redirects the bootloader to an insecure
>> console, they may get access to the system that would otherwise be
>> impossible.
>
> I fail to see how kexec connects with the boot loader - the DTB image
> that's being talked about is one which is passed from the currently
> running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
> also ARM64) that's a direct call chain which doesn't involve any
> boot loader or firmware, and certainly none that would involve the
> passed DTB image.

For OpenPOWER machines, kexec is the bootloader. Our bootloader is a
linux kernel and initramfs with a UI (petitboot) - this means we never
have to write a device driver twice: write a kernel one and you're done
(for booting from the device and using it in your OS).

-- 
Stewart Smith
OPAL Architect, IBM.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
