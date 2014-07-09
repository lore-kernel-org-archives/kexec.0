Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1404932264.26155.75.camel@smoke>
Subject: Re: kexec for aarch64_be
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Jul 2014 11:57:44 -0700
In-Reply-To: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
References: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
Mime-Version: 1.0
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
To: Pankaj Pandey <pankaj.embedded@gmail.com>
Cc: kexec <kexec@lists.infradead.org>

Hi Pankaj,

On Wed, 2014-07-09 at 18:15 +0530, Pankaj Pandey wrote:
> I have found the support for aarch64_be in kexec-tool.git under "master" branch.
> 
> During executing kexec for aarch64_be I am facing "Invalid memory
> segment 0xffffffc080080000 - 0xffffffc080a8efff"  error.
> 
> Any tips or pointers would  be highly appreciated. Thanks in advance !!

Please run kexec with the -d (debug) option and post all the output
including the kexec command line.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
