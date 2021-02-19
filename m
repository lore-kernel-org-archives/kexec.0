Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 19 Feb 2021 19:14:37 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public
 interface
Message-ID: <20210219191436.GA6683@willie-the-truck>
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com>
 <20210219175341.GC6352@willie-the-truck>
 <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 19, 2021 at 02:06:31PM -0500, Pavel Tatashin wrote:
> On Fri, Feb 19, 2021 at 12:53 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> > > machine_kexec_post_load() is called after kexec load is finished. It must
> > > be declared in public header not in kexec_internal.h
> >
> > Could you provide a log of what goes wrong without this patch, please?
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Do you have a link to the report, or did it not go to the list?
> 
> Hi Will,
> 
> https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com/
> 
> It is also linked in the cover letter.

Ah, great. Please add that as a Link: tag in the patch, and in-line the
compiler warning.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
