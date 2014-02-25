Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIPrM-00006y-DK
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 21:48:18 +0000
Date: Tue, 25 Feb 2014 22:47:48 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 06/11] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140225214748.GA21559@pd.tnic>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-7-git-send-email-vgoyal@redhat.com>
 <20140221145910.GE11531@pd.tnic> <20140224164131.GJ4631@redhat.com>
 <20140225203519.77abfa8d@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140225203519.77abfa8d@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, jkosina@suse.cz, Vivek Goyal <vgoyal@redhat.com>

On Tue, Feb 25, 2014 at 08:35:19PM +0100, Petr Tesarik wrote:
> #define BIT(nr)                 (1UL << (nr))
> 
> For my part I'm not convinced it's a better way to do it, unless
> Borislav also wanted to suggest adding an enum for the bit number
> values...

Well,

#define KEXEC_FILE_UNLOAD	BIT(1)

is much more readable.

The enum thing is also nice to have but it's not my personal preference.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
