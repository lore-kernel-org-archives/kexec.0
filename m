Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGooF-0000MT-1u
 for kexec@lists.infradead.org; Wed, 17 Apr 2019 17:57:24 +0000
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: RE: kexec crash on OVMF i386 + x86_64 kernel (Re: [PATCH v4]
 x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernel)
Date: Wed, 17 Apr 2019 17:57:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48AFF5CF@ORSMSX114.amr.corp.intel.com>
References: <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <4dbbbb4b-7af9-bd98-b567-890407a15cd1@ce.jp.nec.com>
 <20190416094554.GF27892@zn.tnic>
 <befd6560-f41a-b142-a839-aaab861dee5a@ce.jp.nec.com>
 <20190417051418.GC8411@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190417051418.GC8411@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

> Added efi people.
> 
> I remember previously Sai did some efi32 tests for kexec, but I'm not sure if he
> tested EFI32 + 64bit kernel.
> 
> Kexec status is not certain because I'm not sure anyone tesed and reported
> issues for that.

No.. I didn't test kexec on EFI32 + 64bit kernel and I also haven't tested kexec'ing from 
kexec'd kernel.

Regards,
Sai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
