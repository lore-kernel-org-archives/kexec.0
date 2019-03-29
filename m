Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9jtV-0005m8-8V
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 05:17:36 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Date: Fri, 29 Mar 2019 05:16:42 +0000
Message-ID: <470e9a92-8433-f2a3-be0a-8306dcf50a73@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328231100.GC1877@MiWiFi-R3L-srv>
 <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
 <20190329035254.GD1877@MiWiFi-R3L-srv>
In-Reply-To: <20190329035254.GD1877@MiWiFi-R3L-srv>
Content-Language: ja-JP
Content-ID: <6DD88A3FFA7E5049ACA55F86D24F606B@gisp.nec.co.jp>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 3/29/19 12:52 PM, bhe@redhat.com wrote:
> 2)
>  __efi_get_rsdp_addr() {
>          for (i = 0; i < nr_tables; i++) {
>                  if (efi_64) {
> 			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
>                          // get guid and table
>                  } else {
> 			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
>                          // get guid and table
>                  }
>                  // check guid and return table if it's valid
>          }
>  }

Thanks. This looks nice and doesn't conflict the direction of refactoring, I think.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
