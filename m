Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692E9C83F15
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t8vf7hUZUHtW9DgCKYW2352vtlbn36tK62jVIdiwJ+Y=; b=UKzBBMHW/qHwX2
	/xfehrvLOuuYY5VWoV+x42jpprPraV0NnaWTZZoOX39ic0QFweO437qshOysGPUTrOWjLSuuMcXk3
	19cShtlMAL2hmDf+A1Lv1+Cxd1rjnkMpBxF/AqmTJ8c1CJxIHMMHl9IIi+CR4rHvh/dvw0ghj1+p3
	56lTmWUfU6FVQ5R6E6o5LvL2BhlMJUpp1VOQk/x39rxqDE637I90G0dONY0O4cHprfxQ5RlSG5YK7
	Nt9JI6ePr6whuTeMEimUN8IUAJlDjMJjt2WBcVxodGxthtVBH+KjWhDQaHlYvxcNGrUdTMrP4FXyP
	dpEZWTQM5Japct/V9+CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjf8g-000000029Ml-33qE;
	Thu, 29 Aug 2024 13:24:38 +0000
Received: from the.earth.li ([2a00:1098:86:4d:c0ff:ee:15:900d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjf8B-000000029Dg-27Is
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 13:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4SsUxAHHD2XiSfMK9a212e44ANeEU+e+fE9aWYn+bJE=; b=SpXzNTJw16lQvy4BiXl4M+gO1C
	X/YJoIDkFgrEqq5d8KnaDYzUPu/62gk0yYm0gxbcTncsHvpJqc9JLwd4JFlqCPah1H+So/oi4HnOg
	dmqJAIZfYwV8dZdQKqDev1dK+qHEsmGi2dKR0ha1UxnwMdi9dA1dCsR7GLquKrGGsZy24oZqVVMZD
	78RtG2CnBczWuj57uGcmkjy7nqpfrR0T2CZBNiSzxCThAftLWAUSz6S/Yq9U+21Fe0DSNYMCZ9n9I
	psZThcU/wEKQ4w5K/cFHaE970E8T/NnaDHK/ncPwoSSz4b41lqdcDOct1rqa7jk9DqW3dl8sGpuww
	prZbRpdw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sjf80-00BZY2-0U;
	Thu, 29 Aug 2024 14:23:56 +0100
Date: Thu, 29 Aug 2024 14:23:56 +0100
From: Jonathan McDowell <noodles@earth.li>
To: ross.philipson@oracle.com
Cc: Ard Biesheuvel <ardb@kernel.org>, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
Message-ID: <ZtB2bP1Mx3zTr9e5@earth.li>
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com>
 <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
 <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_062407_800591_90961DAE 
X-CRM114-Status: GOOD (  28.26  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Aug 28, 2024 at 01:19:16PM -0700, ross.philipson@oracle.com wrote:
> On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
> > On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
> > > 
> > > Hi Ross,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on tip/x86/core]
> > > [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
> > > [cannot apply to herbert-crypto-2.6/master next-20240828]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
> > > 
> > > url:    https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
> > > base:   tip/x86/core
> > > patch link:    https://urldefense.com/v3/__https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIzWfs1XZ$
> > > patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
> > > config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
> > 
> > 
> > This is a i386 32-bit build, which makes no sense: this stuff should
> > just declare 'depends on 64BIT'
> 
> Our config entry already has 'depends on X86_64' which in turn depends on
> 64BIT. I would think that would be enough. Do you think it needs an explicit
> 'depends on 64BIT' in our entry as well?

The error is in x86-stub.c, which is pre-existing and compiled for 32
bit as well, so you need more than a "depends" here.

> > > compiler: clang version 18.1.5 (https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI2SDLdTN$  617a15a9eac96088ae5e9134248d8236e34b91b1)
> > > reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI5MJDdIG$ )
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI-MitiqR$
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > > > drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
> > >     drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
> > > > > drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
> > >     drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast
> > > 
> > > vim +945 drivers/firmware/efi/libstub/x86-stub.c
> > > 
> > >     927
> > >     928  static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
> > >     929                                                   struct boot_params *boot_params)
> > >     930  {
> > >     931          struct slr_entry_intel_info *txt_info;
> > >     932          struct slr_entry_policy *policy;
> > >     933          struct txt_os_mle_data *os_mle;
> > >     934          bool updated = false;
> > >     935          int i;
> > >     936
> > >     937          txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
> > >     938          if (!txt_info)
> > >     939                  return false;
> > >     940
> > >     941          os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
> > >     942          if (!os_mle)
> > >     943                  return false;
> > >     944
> > >   > 945          os_mle->boot_params_addr = (u64)boot_params;
> > >     946
> > >     947          policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
> > >     948          if (!policy)
> > >     949                  return false;
> > >     950
> > >     951          for (i = 0; i < policy->nr_entries; i++) {
> > >     952                  if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
> > >     953                          policy->policy_entries[i].entity = (u64)boot_params;
> > >     954                          updated = true;
> > >     955                          break;
> > >     956                  }
> > >     957          }
> > >     958
> > >     959          /*
> > >     960           * If this is a PE entry into EFI stub the mocked up boot params will
> > >     961           * be missing some of the setup header data needed for the second stage
> > >     962           * of the Secure Launch boot.
> > >     963           */
> > >     964          if (image) {
> > >     965                  struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
> > >     966                                              offsetof(struct boot_params, hdr));
> > >     967                  u64 cmdline_ptr;
> > >     968
> > >     969                  boot_params->hdr.setup_sects = hdr->setup_sects;
> > >     970                  boot_params->hdr.syssize = hdr->syssize;
> > >     971                  boot_params->hdr.version = hdr->version;
> > >     972                  boot_params->hdr.loadflags = hdr->loadflags;
> > >     973                  boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
> > >     974                  boot_params->hdr.min_alignment = hdr->min_alignment;
> > >     975                  boot_params->hdr.xloadflags = hdr->xloadflags;
> > >     976                  boot_params->hdr.init_size = hdr->init_size;
> > >     977                  boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
> > >     978                  efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
> > >     979                                   &cmdline_ptr);
> > >   > 980                  boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
> > >     981          }
> > >     982
> > >     983          return updated;
> > >     984  }
> > >     985
> > > 
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://urldefense.com/v3/__https://github.com/intel/lkp-tests/wiki__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIy5kGTJf$
> > > 
> 
> 

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
     much of : 23 - Red Dwarf.     | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
