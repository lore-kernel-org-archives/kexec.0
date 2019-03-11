Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3SpK-0005hv-Rr
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 21:51:20 +0000
Date: Mon, 11 Mar 2019 22:51:15 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v3 0/7] selftests/ima: add kexec and kernel module tests
Message-ID: <20190311215115.GB13024@x230>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, Dave Young <dyoung@redhat.com>

Hi Mimi,

> Mimi Zohar (6):
>   selftests/ima: cleanup the kexec selftest
>   selftests/ima: define a set of common functions
>   selftests/ima: define common logging functions
>   kselftest/ima: define "require_root_privileges"
>   selftests/ima: kexec_file_load syscall test
>   selftests/ima: loading kernel modules
Whole patchset LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Petr Vorel (1):
>   selftests/ima: Add missing '=y' to config options

>  tools/testing/selftests/ima/Makefile               |   3 +-
>  tools/testing/selftests/ima/config                 |   7 +-
>  tools/testing/selftests/ima/ima_common_lib.sh      | 173 +++++++++++++++++++
>  tools/testing/selftests/ima/test_kernel_module.sh  |  93 ++++++++++
>  .../testing/selftests/ima/test_kexec_file_load.sh  | 190 +++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh     |  53 ++----
>  6 files changed, 476 insertions(+), 43 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/ima_common_lib.sh
>  create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
>  create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh


Kind regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
