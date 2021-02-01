Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400059.outbound.protection.outlook.com
 ([40.107.140.59] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6OdC-0005YA-Ir
 for kexec@lists.infradead.org; Mon, 01 Feb 2021 02:08:01 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v2] makedumpfile: Add initial mips64 support
Date: Mon, 1 Feb 2021 02:07:44 +0000
Message-ID: <OSBPR01MB1991EE99FDCE26A9F5FA636ADDB69@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <1611908823-17601-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1611908823-17601-1-git-send-email-tangyouling@loongson.cn>
Content-Language: ja-JP
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: Jinyang He <hejinyang@loongson.cn>, kexec-ml <kexec@lists.infradead.org>, Huacai Chen <chenhuacai@loongson.cn>

-----Original Message-----
> Patch adds support for mips64 in makedumpfile. It takes care of vmalloc,
> module and directly map kernel memory region's translation. Currently we
> only support 3 leverl 16K pages and VA_BITS as 48.
> 
> The changes were tested on a mips64 Loongson-3A4000 processor. The dump
> compression and filtering (for all dump levels 1,2,4,8,16 and 31) tests
> are succussfull.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
> v1 -> v2:
>  - Move max_physmem_bits and section_size_bits to get_machdep_info_mips64().

Thanks for updating, applied.
https://github.com/makedumpfile/makedumpfile/commit/7f185d29aa1794a82a090c748aae2f7bf240fb49

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
