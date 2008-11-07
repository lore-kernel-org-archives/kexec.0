Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6] helo=vavatch.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KyGOH-0007E0-FE
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 01:44:01 +0000
Date: Fri, 7 Nov 2008 01:43:42 +0000
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Message-ID: <20081107014342.GA9841@srcf.ucam.org>
References: <fa.UVpnVba3yRAWG3rGZ0sk20JE9hs@ifi.uio.no>
	<fa.FPBNKx3BSvZHPZ+eXD4Tb+fuRYk@ifi.uio.no>
	<fa.PvVEuEo+f/t4sLmcGyN2Tsl8zYg@ifi.uio.no>
	<fa.zzFdOXisTZzBaE1+ueGIYmt+Z5c@ifi.uio.no>
	<fa.vQ6HVRcPFFr1zpcXFFOjEPtDdNk@ifi.uio.no>
	<fa.ckUqcrtVKbxAkjNggIdajBTHr9Q@ifi.uio.no>
	<49139A43.4000203@shaw.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49139A43.4000203@shaw.ca>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>

On Thu, Nov 06, 2008 at 07:30:43PM -0600, Robert Hancock wrote:

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8fd145917fb62368a9b80db59562c20576238f5a
> 
> This patch ignores the RESET_REG_SUP flag and just tries using the reset 
> register anyway if it thinks it's valid. So we may attempt ACPI reset on 
> machines which don't indicate it's supported.

Yeah, that sounds very wrong.

> The patch description mentioned that some machines didn't reboot after 
> S3 suspend without this patch. However, we recently had this patch merged:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a68823ee5285e65b51ceb96f8b13a5b4f99a6888
> 
> Is it possible that the problem fixed there is the true cause of this 
> reboot after S3 problem?

Oh, yeah, could be. Given the From:, I should really have thought of 
that :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
