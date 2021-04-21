Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.tuxforce.de ([84.38.66.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZLFX-00DEF8-SA
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 22:23:13 +0000
Subject: Re: [PATCH 1/2] test_firmware: add suspend support to test buggy
 drivers
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-2-mcgrof@kernel.org>
From: Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <3ef0de52-5d17-c950-942f-29932df54880@tuxforce.de>
Date: Thu, 22 Apr 2021 00:23:08 +0200
MIME-Version: 1.0
In-Reply-To: <20210416235850.23690-2-mcgrof@kernel.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Luis Chamberlain <mcgrof@kernel.org>, rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>


On 17/04/2021 01:58, Luis Chamberlain wrote:
> Lukas Middendorf reported a situation where a driver's
> request_firmware() call on resume caused a stall. Upon
> inspection the issue was that the driver in question was
> calling request_firmware() only on resume, and since we
> currently do not have a generic kernel VFS freeze / thaw
> solution in place we are allowing races for filesystems
> to race against the disappearance of a block device, and
> this is presently an issue which can lead to a stall.
> 
> It is difficult to reproduce this unless you have hardware
> which mimics this setup. So to test this setup, let's just
> implement support for doing these wacky things. This lets
> us test that corner case easily as follows.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

The resume test functionality added to test_firmware works as intended 
in reproducing the stall bug I reported.

However, the fw_test_resume.sh seems to be incomplete.

> +usage()
> +{
> +	echo "Usage: $0 [ -v ] | [ -h | --help]"
> +	echo ""
> +	echo "    --check-resume-test   Verify resume test"
> +	echo "    -h|--help             Help"
> +	echo
> +	echo "Without any arguments this will enable the resume firmware test"
> +	echo "after suspend. To verify that the test went well, run with -v".
> +	echo
> +	exit 1
> +}

The "-v" is not implemented as an alias to "--check-resume-test"

> +
> +verify_resume_test()
> +{
> +	trap "test_finish" EXIT
> +}

Does not seem to do anything regarding checking, just some cleanup.

> +
> +parse_args()
> +{
> +	if [ $# -eq 0 ]; then
> +		config_enable_resume_test
> +	else
> +		if [[ "$1" = "--check-resume-test" ]]; then
> +			config_disable_resume_test
> +			verify_resume_test
> +		else
> +			usage
> +		fi
> +	fi
> +}
> +

there should likely be a call

parse_args "$@"

> +exit 0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
