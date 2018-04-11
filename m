Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
References: <cover.1495514291.git.panand@redhat.com>
 <59312080.1090906@arm.com> <1963984d-e78e-a5b2-f1a2-fb0a789a505e@redhat.com>
 <CAB=otbT23ySN4VC6G0sBKF5p4SvsnG8PS-C_beBgn8YJUsbw9Q@mail.gmail.com>
 <71f0a333-8bfb-3755-c9fd-e30bf2280339@cisco.com>
 <5599813d-f83c-d154-287a-c131c48292ca@arm.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <79a879dc-e729-15ff-a5df-42684bd7e22a@infradead.org>
Date: Wed, 11 Apr 2018 08:59:58 -0700
MIME-Version: 1.0
In-Reply-To: <5599813d-f83c-d154-287a-c131c48292ca@arm.com>
Content-Language: en-US
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
To: James Morse <james.morse@arm.com>, Kostiantyn Iarmak <kiarmak@cisco.com>
Cc: Pratyush Anand <panand@redhat.com>, mark.rutland@arm.com, bhe@redhat.com, kexec@lists.infradead.org, horms@verge.net.au, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On 04/04/2018 06:28 AM, James Morse wrote:
> We ended up with the check-summing code because its the default behaviour of
> kexec-tools on other architectures.
> 
> One alternative is to rip it out for arm64.

Or add arm64 support to kexec-lite:

  https://github.com/antonblanchard/kexec-lite

Or accept my bypass patch:

  http://lists.infradead.org/pipermail/kexec/2015-October/014573.html

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
