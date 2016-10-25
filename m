Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: kexec and arm64 advice
References: <CAKYm0coteEEapCNwmj+KmGd57C_C3--nXQfjyD_FLoGXSkqMkQ@mail.gmail.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <3118d747-8f11-fae5-9541-0fb0917eaa14@infradead.org>
Date: Tue, 25 Oct 2016 09:57:29 -0700
MIME-Version: 1.0
In-Reply-To: <CAKYm0coteEEapCNwmj+KmGd57C_C3--nXQfjyD_FLoGXSkqMkQ@mail.gmail.com>
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
To: Simon T <smith.not.western@gmail.com>, kexec@lists.infradead.org

On 10/24/2016 07:42 AM, Simon T wrote:
> Both tools and kernel appear to build fine, however when it
> comes time to kexec, I encounter this message: "kexec_load failed:
> Function not implemented"

It seems your kernel needs kexec support. Try something like:

  cat /proc/config.gz | gunzip | egrep 'KEXEC'

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
