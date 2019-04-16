Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGKvA-0005GJ-Gk
 for kexec@lists.infradead.org; Tue, 16 Apr 2019 10:02:33 +0000
Received: by mail-wm1-x341.google.com with SMTP id z11so24690752wmi.0
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2019 03:02:31 -0700 (PDT)
Date: Tue, 16 Apr 2019 12:02:26 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190416100226.GA117053@gmail.com>
References: <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic> <20190416095209.GG27892@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190416095209.GG27892@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>


* Borislav Petkov <bp@alien8.de> wrote:

> I'll queue the below in the next days if there are no more complaints:

Just a minor style nit, this was inherited from existing code:

> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;

You might want to update that to the canonical form of:

> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;

Looks good otherwise.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
