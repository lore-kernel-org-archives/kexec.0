Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9ndF-00054q-PG
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 09:17:03 +0000
Date: Fri, 29 Mar 2019 17:16:55 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190329091655.GE7627@MiWiFi-R3L-srv>
References: <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
 <20190329082929.GH4234@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190329082929.GH4234@localhost.localdomain>
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 03/29/19 at 04:29pm, Chao Fan wrote:
> On Fri, Mar 29, 2019 at 07:20:38AM +0000, Junichi Nomura wrote:
> >Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> >boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> >in the early parsing code tries to search RSDP from EFI table but
> >that will crash because the table address is virtual when the kernel
> >was booted by kexec.
> [...]
> >-			guid  = tbl->guid;
> >-			table = tbl->table;
> >-		}
> >-
> >-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> >-			rsdp_addr = table;
> >-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> >-			return table;
> >-	}
> >+	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
> >+#else
> >+	return 0;
> > #endif
> >-	return rsdp_addr;
> 
> I remeber the rsdp_addr is defined before #ifdef CONFIG_EFI
> If so, you don't need
> #else
> 	return 0;

it doesn't change the old logic. Junichi moved rsdp_addr definition inside
the CONFIG_EFI iedeffery block.
> 
> BY the way, what's your patch based on? I like add patch on my local
> branch and then review code, but failed.
> I try to use 'patch -p1 <' your patch to the latest tip master branch,
> but failed.
> 
> Thanks,
> Chao Fan
> 
> > }
> > 
> > static u8 compute_checksum(u8 *buffer, u32 length)
> >@@ -221,6 +284,9 @@ acpi_physical_address get_rsdp_addr(void)
> > 		pa = boot_params->acpi_rsdp_addr;
> > 
> > 	if (!pa)
> >+		pa = kexec_get_rsdp_addr();
> >+
> >+	if (!pa)
> > 		pa = efi_get_rsdp_addr();
> > 
> > 	if (!pa)
> >
> >
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
