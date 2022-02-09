From: Baoquan He <bhe@redhat.com>
Date: Wed, 9 Feb 2022 11:21:56 +0800
Subject: Is it possible to use a stream for initrd=
In-Reply-To: <CAHfPjO9MPOP4ZhmLtoyp+YxdreMNCOiy7nApm+uweaSJX5XvpQ@mail.gmail.com>
References: <CAHfPjO9MPOP4ZhmLtoyp+YxdreMNCOiy7nApm+uweaSJX5XvpQ@mail.gmail.com>
Message-ID: <YgMzVA7rzLYAHWNi@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/08/22 at 04:36pm, Tobias Powalowski wrote:
> Hi,
> just a quick question, is it possible to use a stream for initrd= parameter?
> I want to save RAM/Space and directly load the ramdisk into memory for reboot.
> initrd=< ... does not work.

Are you using kexec -l or kexec -p to reboot? Can you write down your
operation steps?


