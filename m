Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8gqJ-0000hE-BN
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 07:50:02 +0000
Date: Tue, 26 Mar 2019 15:49:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
Message-ID: <20190326074942.GA19708@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
 <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
 <1553546236.5561.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1553546236.5561.7.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org

On 03/25/19 at 04:37pm, Mimi Zohar wrote:
> On Mon, 2019-03-25 at 16:09 +0800, Dave Young wrote:
> > Hi Mimi
> > On 03/22/19 at 03:35pm, Mimi Zohar wrote:
> > > Verify IMA is enabled before failing tests or emitting irrelevant
> > > messages.  Also, don't skip the test if signatures are not required.
> > > =

> > > Suggested-by: Dave Young <dyoung@redhat.com>
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > > Dave, if this patch resolves the outstanding issues, I can fold these
> > > changes into the original patches. (Reminder, these patches will need=
 to
> > > be updated to support the "lockdown" patch set.)
> > =

> > They looks good to me, thanks for the update
> =

> I've folded the kexec_file_load changes into the kexec_file_load test.
> =A0The remaining kexec_load change is left as a separate patch, since it
> is dependent on the ikconfig change.
> =

> > Feel free to add my reviewed-by, I did some tests although not cover all
> > ima cases.
> =

> Thanks! =A0Is this meant as a general "reviewed-by" for all of the
> patches or just this specific one?

Thank you for taking this as a separate kexec tests, I think it can be used=
 for these delta fixes

I read all the patches and reviewed the kexec stuff, but I do not
understand all the IMA logic yet although I did some simple ima
tests.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
