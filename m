Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9iZg-0006tS-Q4
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 03:53:02 +0000
Date: Fri, 29 Mar 2019 11:52:54 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329035254.GD1877@MiWiFi-R3L-srv>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328231100.GC1877@MiWiFi-R3L-srv>
 <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 03/29/19 at 03:34am, Junichi Nomura wrote:
> On 3/29/19 8:11 AM, bhe@redhat.com wrote:
> > On 03/28/19 at 07:43am, Junichi Nomura wrote:
> >>  /* Search EFI system tables for RSDP. */
> >> -static acpi_physical_address efi_get_rsdp_addr(void)
> >> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)
> > 
> > Here parameter 'size' and 'efi_64' seems a little duplicated on
> > functionality. Only passing efi_64 can deduce the size? Personal
> > opinion.
> 
> Yes. But I'm not sure which is preferred.
> 
> The current code is:
> 

I would like to change them like below two cases. I personally prefer
the 2nd one. Feel free to take one you like better.

1)
 __efi_get_rsdp_addr() {

	size = efi_64 ? sizeof(efi_config_table_64_t):sizeof(efi_config_table_32_t);;

Or if/else sytle.

         for (i = 0; i < nr_tables; i++) {
                 config_tables += size;
                 if (efi_64) {
                         efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
                         // get guid and table
                 } else {
                         efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
                         // get guid and table
                 }
                 // check guid and return table if it's valid
         }
 }
 
2)
 __efi_get_rsdp_addr() {
         for (i = 0; i < nr_tables; i++) {
                 if (efi_64) {
			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
                         // get guid and table
                 } else {
			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
                         // get guid and table
                 }
                 // check guid and return table if it's valid
         }
 }
> 
> Or we could create 2 functions, __efi_get_rsdp_addr32() and __efi_get_rsdp_addr64(),
> and let efi_get_rsdp_addr() to choose which one to use based on signature.
> 
> > It might be worth adding code comments here to tell why we only care
> > about 64bit kexec booting?
> 
> I think so. I'll add a comment.
> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
