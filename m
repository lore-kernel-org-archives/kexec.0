Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faHjo-0006fc-HC
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 09:36:46 +0000
Date: Tue, 3 Jul 2018 17:35:56 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5 8/8] module: replace the existing LSM hook in
 init_module
Message-ID: <201807031757.qpz6yHPo%fengguang.wu@intel.com>
References: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, kbuild-all@01.org, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/kexec-firmware-support-system-wide-policy-requiring-signatures/20180703-011114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> security/loadpin/loadpin.c:178:40: sparse: mixing different enum types
   security/loadpin/loadpin.c:178:40:     int enum kernel_load_data_id  versus
   security/loadpin/loadpin.c:178:40:     int enum kernel_read_file_id

vim +178 security/loadpin/loadpin.c

   175	
   176	static int loadpin_load_data(enum kernel_load_data_id id)
   177	{
 > 178		return loadpin_read_file(NULL, id);
   179	}
   180	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
