Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h977d-0000v0-5t
 for kexec@lists.infradead.org; Wed, 27 Mar 2019 11:53:34 +0000
Date: Wed, 27 Mar 2019 12:53:27 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v5 8/9] selftests/kexec: check kexec_load and
 kexec_file_load are enabled
Message-ID: <20190327115327.GB13687@dell5510>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
 <1553607257-18906-9-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1553607257-18906-9-git-send-email-zohar@linux.ibm.com>
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

Hi Mimi, Dave,

> Skip the kexec_load and kexec_file_load tests, if they aren't configured
> in the kernel.  This change adds a new requirement that ikconfig is
> configured in the kexec_load test.

> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
