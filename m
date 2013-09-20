Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMwff-000329-CA
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 09:06:40 +0000
Date: Fri, 20 Sep 2013 10:06:04 +0100
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [edk2] Corrupted EFI region
Message-ID: <20130920090604.GB4785@console-pimps.org>
References: <20130806141036.GD14891@pd.tnic> <520116D1.2010000@redhat.com>
 <20130807151935.GJ17920@pd.tnic>
 <CCFD3CBD-62B0-4046-B96D-18CB1A815F72@apple.com>
 <20130807201908.GG2515@console-pimps.org>
 <D5982201-6DC4-469F-812A-74A8402ADEE9@apple.com>
 <20130808101730.GJ2515@console-pimps.org>
 <20130913203812.GA312@anatevka.fc.hp.com>
 <20130916105920.GB2697@console-pimps.org>
 <20130918192414.GB3345@anatevka.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130918192414.GB3345@anatevka.fc.hp.com>
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
To: jerry.hoemann@hp.com
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Josh Triplett <josh@joshtriplett.org>, linux-efi@vger.kernel.org, Linn Crosetto <linn.crosetto@hp.com>, Gleb Natapov <gleb@redhat.com>, terry.lee@hp.com, Randy Wright <rwright@hp.com>, Laszlo Ersek <lersek@redhat.com>, kexec <kexec@lists.infradead.org>, Andrew Fish <afish@apple.com>, lkml <linux-kernel@vger.kernel.org>, chrisp@hp.com, Brian Richardson <brian.richardson@intel.com>, Borislav Petkov <bp@alien8.de>, samer.el-haj-mahmoud@hp.com, "H. Peter Anvin" <hpa@zytor.com>, Colin Ian King <colin.king@canonical.com>, linda.knippers@hp.com, David Woodhouse <dwmw2@infradead.org>, randy.pawell@hp.com, dong.wei@hp.com

On Wed, 18 Sep, at 01:24:14PM, jerry.hoemann@hp.com wrote:
> Matt,
> 
> I conducted the following experiments on a 3.11 kernel:
 
Jerry, could you paste your memory map from the kernel log?

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
